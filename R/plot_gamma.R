
library(ggplot2)

## mean = shape / rate
## <=> rate = shape / mean = 0.1 / 0.1 = 1

plot_samples <- qplot(rgamma(1e5, shape = 0.1, rate = 1))


x <- seq(from = 0.001, to = 0.1, by = 0.0001)

plot_density <- qplot(x = x,
                      y = dgamma(x = x, shape = 0.1, rate = 1),
                      geom = "line") +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  xlab("Value") +
  ylab("Density") +
  ggtitle("Gamma(mean = 0.1, shape = 0.1)")

dir.create("figures")

pdf("figures/gamma_density.pdf",
    height = 3.5)
print(plot_density)
dev.off()


