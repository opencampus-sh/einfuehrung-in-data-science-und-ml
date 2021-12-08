library(readr)
library(VIM)
library(dplyr)

sleep <- VIM::sleep

# VIM Aggregation Plot
sleep %>% aggr(combined=TRUE, numbers=TRUE)

# Listwise deletion
sleep_deletion <- na.omit(sleep)
sleep_deletion %>% aggr(combined=TRUE, numbers=TRUE)

# VIM Hot-Deck Imputation
sleep_hotdeck1 <- sleep %>%  hotdeck()
sleep_hotdeck1 %>% aggr(combined=TRUE, numbers=TRUE)
ggplot(sleep_hotdeck1) +
  geom_point(aes(x=Sleep, y=Dream, color=Sleep_imp))

sleep_hotdeck2 <- sleep %>%  hotdeck(ord_var = "Dream")
sleep_hotdeck2 %>% aggr(combined=TRUE, numbers=TRUE)

sleep_hotdeck3 <- sleep_hotdeck2 %>%  hotdeck(ord_var = "Sleep")
sleep_hotdeck3 %>% aggr(combined=TRUE, numbers=TRUE)

# VIM Iterative Robust Model Imputation (IRMI)
sleep_irmi <- sleep %>%  irmi()
ggplot(sleep_irmi) +
  geom_point(aes(x=Sleep, y=Dream, color=Sleep_imp))


# Impact
cor(sleep_deletion$Sleep, sleep_deletion$Dream)
cor(sleep_hotdeck1$Sleep, sleep_hotdeck1$Dream, use = "complete.obs")
cor(sleep_hotdeck2$Sleep, sleep_hotdeck2$Dream, use = "complete.obs")
cor(sleep_hotdeck3$Sleep, sleep_hotdeck3$Dream, use = "complete.obs")
cor(sleep_irmi$Sleep, sleep_irmi$Dream)

