library(ggplot2)
library(dplyr)
library(purrr)
library(tibble)
library(stringr)

## get file sizes

get_results <- function(directory) {

    files <- dir(directory, full.names = TRUE)

    parsed <- str_match(files, "//([0-9e-]+)_([0-9]+)\\.")

    size <- map_dbl(files, file.size)

    tibble(file = files, Ne = as.numeric(parsed[,2]), rep = as.numeric(parsed[,3]), size = size)
}

results_wf <- get_results("simulations/wf/")

results_background <- get_results("simulations/background/")
colnames(results_background)[2] <- "r"

model <- lm(Ne ~ size, data = results_wf)

results_background$Ne <- predict(model, newdata = results_background)


plot_wf <- qplot(x = size, y = Ne, data = results_wf) +
  geom_abline(intercept = coef(model)[1], slope = coef(model)[2]) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  scale_x_continuous(labels = c(0, "100k", "200k", "300k"),
                     breaks = c(0, 100e3, 200e3, 300e3)) +
  xlab("File size (kb)")
  
  
  
plot_background <- plot_wf +
  geom_point(aes(x = size, y = Ne,
                 colour = factor(r)),
             data = results_background) +
  theme(legend.title = element_blank()) +
  scale_colour_manual(values = c("#fa9fb5", "#c51b8a"))


pdf("figures/ne_joke1.pdf",
    height = 3.5)
print(plot_wf)
dev.off()

pdf("figures/ne_joke2.pdf",
    height = 3.5)
print(plot_background)
dev.off()


summarise(group_by(results_background, r),
          mean = mean(Ne))
