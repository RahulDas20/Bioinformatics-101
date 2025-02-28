#Bar plot for BRCA1 Gene
complete_data %>%
  filter(gene == "BRCA1") %>%
  ggplot(.,aes(sample, FPKM, fill = tissue)) +
  geom_bar(stat = "identity")

#Density plot for BRCA gene
complete_data %>%
  filter(gene == "BRCA1") %>%
  ggplot(.,aes(FPKM, fill = tissue)) +
  geom_density(alpha = 0.5)


#Boxplot for BRCA gene

complete_data %>%
  filter(gene == "BRCA1") %>%
  ggplot(., aes(FPKM, metastasis)) +
  geom_boxplot()


#Scatter plot
complete_data %>%
  filter(gene == "BRCA1" | gene == "BRCA2") %>%
  spread(key = gene, value = FPKM) %>%
  ggplot(., aes(BRCA1,BRCA2, colour = tissue)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)


#heat map of different genes
genes_of_interest <- c('BRCA1','BRCA2','TP53','ALK','MYCN')


P <- complete_data %>%
  filter(gene %in% genes_of_interest) %>%
  ggplot(.,aes(sample, gene, fill = FPKM)) +
  geom_tile() +
  scale_fill_gradient(low = 'white', high = 'red')

ggsave(P, filename = "heatmap_save1.pdf", width = 10, height = 8)
