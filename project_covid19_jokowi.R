#final project kmmi

library("tidytext")
library("tidyverse")
library("igraph")
library("rgexf")

#mengimport dataset serta memilih 2 kolom screen name dan text 
covid19_project <- read.csv(file = "covid19_tweet.csv")
covid19_project <- covid19_project %>% 
  select(screen_name,text) 
  
#mengambil tweet yang hanya menggunakan jokowi  
covid_19_project_jokowi <- covid19_project%>% 
  filter(str_detect(text,"jokowi"))

#cleansing kolom text
mentioned_jkw <- str_extract_all( string = covid_19_project_jokowi$text, pattern = "@[[:alnum:]_]*", simplify = TRUE)

#memasukan kolom yang di cleansing ke data frame
mentioned_jkw <- data.frame(mentioned_jkw)

#menggabungkan seluruh kolom mentioned jkw ke covid_19_project_jokowi
mentioned_jkw <- mentioned_jkw %>%
  unite("mention", sep = " ")
covid_19_project_jokowi$mention <- paste0(mentioned_jkw$mention)

#menghitung jumlah mention
covid_19_project_jokowi$jumlah_mention <- str_count(covid_19_project_jokowi$mention, '\\S+')

#menghapus text yang tidak memention
adj_objek <- covid_19_project_jokowi %>%
  filter( jumlah_mention > 0) %>%
  select(-c(text,jumlah_mention)) %>%
  unnest_tokens(target, mention, token = "ngrams", n=1, to_lower = FALSE)

#membuat igraph objek
f_net <- simplify(graph_from_data_frame(d = adj_objek, directed = TRUE),
                  remove.loops = TRUE, remove.multiple = FALSE,
                  edge.attr.comb = igraph_opt("edge.attr.comb"))

#save 
write_graph(graph = f_net, file = "covid_19_project_jokowi.graphml", format = "graphml")


#--VISUALIZING PROSES--#

#membuat nodes
nodes_df <- data.frame(ID = c(1:vcount(f_net)), NAME = V(f_net)$name)

#membuat edges
edges_df <- as.data.frame(get.edges(f_net, c(1:ecount(f_net))))

#menyimpan nama edges dan nodes
write.gexf(nodes = nodes_df, edges = edges_df, defaultedgetype = "directed",
           output = "covid19_jokowi.gexf")

#menghitung centrality !IMPORTANT

#1. degre centrality
degree_centrality <- centr_degree(f_net, mode = "all")
degree_centrality <- data.frame(degre = degree_centrality$res)

#2. betweness centrality
betweenness_centrality <- betweenness(graph = f_net)
betweenness_centrality <- data.frame(betweeness = betweenness_centrality)

#3. eigenvector centrality
eigenvector_centrality <- eigen_centrality(graph = f_net, directed = TRUE)
eigenvector_centrality <- data.frame(eigen = eigenvector_centrality[["vector"]])

#--visualisasi data statis--#
sampled_data <- adj_objek %>%
  count(screen_name, target, sort = TRUE) %>%
  filter(n>=1) #minim memention jokowi 1x

#membuat objek di graph
net <- graph_from_data_frame(d = sampled_data, directed = FALSE)

#melihat atribut network

#1. eigenvector
ec <- eigen_centrality(graph = net, directed = FALSE, weights = NA)$vector
plot(net, vertex.size = ec*10, layout = layout_with_fr)

#2. degre
dc <- degree(graph = net, mode = "all")
plot(net, vertex.size=dc*10, layout=layout_with_fr)

#3. betweness
bc <- betweenness(graph = net)
plot(net,vertex.size=bc*10, layout=layout_with_dh)
