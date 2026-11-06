library(ggplot2)

df <- read.table("nkx2_1_data.tsv", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
df$log2_tpm <- log2(df$tpm + 1)
df$sample_type <- factor(df$sample_type, levels = c("Solid_Tissue_Normal", "Primary_Tumor"))

normal <- df$log2_tpm[df$sample_type == "Solid_Tissue_Normal"]
tumor  <- df$log2_tpm[df$sample_type == "Primary_Tumor"]
p_val  <- formatC(wilcox.test(tumor, normal)$p.value, format = "e", digits = 1)

label_normal <- paste0("Solid Tissue Normal\n(n = ", length(normal), ")")
label_tumor  <- paste0("Primary Tumor\n(n = ", length(tumor), ")")

p <- ggplot(df, aes(x = sample_type, y = log2_tpm, fill = sample_type)) +
  geom_boxplot(
    notch = TRUE,
    width = 0.5,
    outlier.size = 1.2,
    outlier.shape = 16,
    color = "black",
    linewidth = 0.6
  ) +
  scale_fill_manual(values = c("Solid_Tissue_Normal" = "#1B9E77", "Primary_Tumor" = "#D95F02")) +
  scale_x_discrete(labels = c("Solid_Tissue_Normal" = label_normal, "Primary_Tumor" = label_tumor)) +
  scale_y_continuous(limits = c(0, 10), breaks = seq(0, 10, by = 2)) +
  labs(
    title = "Lung Adenocarcinoma",
    subtitle = paste0("p = ", p_val),
    y = expression(Log[2](TPM + 1)),
    x = NULL
  ) +
  theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    axis.text.x = element_text(color = "black", size = 11, lineheight = 0.9),
    axis.text.y = element_text(color = "black", size = 11),
    axis.title.y = element_text(face = "plain", size = 12),
    legend.position = "none"
  )

ggsave("LUAD_ggplot.png", plot = p, width = 4.8, height = 6.2, dpi = 300)
