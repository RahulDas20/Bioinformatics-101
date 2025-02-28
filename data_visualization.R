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


#

