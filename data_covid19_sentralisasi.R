library(tidyverse)
library(tidytext)

install.packages("igraph")
install.packages("rgexf")

library(igraph)
library(rgexf)

#import data
df_covid19 <- read.csv(file = "covid19_tweet.csv")  

#memilih kolom, screen name & text
df_covid19 <- df_covid19 %>%
  select(screen_name, text)

#cleansing kolom text
mentioned <- str_extract_all( string = df_covid19$text, pattern = "@[[:alnum:]_]*", simplify = TRUE)

#merubah tipe data dari matrix ke data frame
mentioned <- data.frame(mentioned)

#menggabungkan seluruh kolom mentioned ke df_covid19
mentioned <- mentioned %>%
  unite("mention", sep = " ")

#menggabungkan data mentioned ke df_covid19
df_covid19$mention <- paste0(mentioned$mention)

#menghitung jumlah mention
df_covid19$jumlah_mention <- str_count(df_covid19$mention, '\\S+')

#membuang text yang tidak memention 
adj_objek <- df_covid19 %>%
  filter( jumlah_mention > 0) %>%
  select(-c(text,jumlah_mention)) %>%
  unnest_tokens(target, mention, token = "ngrams", n=1, to_lower = FALSE) #menggunakan kolom mention, bukan data mentioned

# create igraph objek
d_net <- simplify(graph_from_data_frame(d = adj_objek, directed = TRUE),
                  remove.loops = TRUE, remove.multiple = FALSE,
                  edge.attr.comb = igraph_opt("edge.attr.comb"))

# save langsung ----
write_graph(graph = d_net, file = "df_covid19test.graphml", format = "graphml")

#membuat nodes
nodes_df <- data.frame(ID = c(1:vcount(d_net)), NAME = V(d_net)$name)

#membuat edges
edges_df <- as.data.frame(get.edges(d_net, c(1:ecount(d_net))))

#menyimpan nama edges dan nodes
write.gexf(nodes = nodes_df, edges = edges_df, defaultedgetype = "directed",
           output = "sampel_net.gexf")

#menghitung centrality !IMPORTANT

#1. degre centrality
degree_centrality <- centr_degree(d_net, mode = "all")
degree_centrality <- data.frame(degre = degree_centrality$res)

#2. closeness centrality
closeness_centrality <- closeness(d_net, mode = "all")
closeness_centrality <- data_frame(closness = closeness_centrality)

#3. betweness centrality
betweenness_centrality <- betweenness(graph = d_net)
betweenness_centrality <- data.frame(betweeness = betweenness_centrality)

#4. eigenvector centrality
eigenvector_centrality <- eigen_centrality(graph = d_net, directed = TRUE)
eigenvector_centrality <- data.frame(eigen = eigenvector_centrality[["vector"]])


#--visualisasi data statis--#
sampled_data <- adj_objek %>%
  count(screen_name, target, sort = TRUE) %>%
  filter(n>=2)

#membuat objek di graph
net <- graph_from_data_frame(d = sampled_data, directed = FALSE)
plot(net)

#melihat atribut network --> contoh eigenvector 
ec <- eigen_centrality(graph = net, directed = FALSE, weights = NA)$vector
plot(net, vertex.size = ec*10, layout = layout_with_fr)

#mencoba layout
coords <- layout_(net, as_star(), normalize())
plot(net, vertex.size = ec*10, layout = coords)

plot(net, vertex.size = ec*10, layout = layout_with_dh)

wc <- cluster_walktrap(graph = net)
plot(wc, net, vertex.size=ec*30, layout=layout_with_lgl)

#tugas: buat plot visualisasi dari igraph object d_net dengan besar edges ditentukan 
#dari degree, closeness, betweness centrality

#degree
dc <- degree(graph = net, mode = "all")
plot(net, vertex.size=dc*10, layout=layout_with_dh)

#closeness
cc <- closeness(net, mode = "all")

#betweness
bc <- betweenness(graph = net)
plot(net,vertex.size=bc*10, layout=layout_with_dh)
