library(tidyr)
library(ggplot2)
source("ggplot_theme.txt")
#in dir 'gannt_charts'
gannt = read.csv("data/project_timeline.csv")
acts = gannt$Activity %>% as.character %>% unique

g.gannt = pivot_longer(gannt, cols = 4:5, names_to = "start.end", values_to = "month")
g.gannt


g.gannt$Activity = factor(g.gannt$Activity, levels = rev(acts)) #sort according to order in data

p1 = ggplot(g.gannt, 
    aes(
        x = month, y = Activity, 
        color = factor(Project.element, levels = c("Quantification and detection", "Life stage quantification", "Both objectives", "Technology transfer")), 
        group = Item
    )
) +
    geom_line(linewidth = 10) +
    labs(x="Project month", y=NULL, color = "Objective") +
    scale_color_manual(values = c("Quantification and detection" = "light grey", "Life stage quantification" = "grey49", "Both objectives" = "grey31", "Technology transfer" = "black")) +
    scale_x_continuous(limits = c(1,24), expand = c(0.01,0.01), breaks = c(6,12,18,24)) +
    my_gg_theme.def_size  +
    theme(
        legend.position = c(0.821,0.845),
        legend.background = element_rect(color = "black"),
        plot.background = element_rect(color = "black")
    )

p1

pdf("figures/project_timeline.pdf", width = 8, height = 5)
p1
dev.off()

