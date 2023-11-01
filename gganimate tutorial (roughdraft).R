#install gganimate
install.packages("gganimate")
#load ggplot2 and gganimate
library("ggplot2")
library("gganimate")
#load example data titled "Snake perch leaving"
Perch <- read.csv("Snake perch leaving.csv")
#Lets a create a plot that shows the number of snakes of each species that left the perch at each of the height and target conditions.
plot1 <- ggplot(Perch, aes(x = Target,
                          y = Left.the.perch,
                          fill = Species)) + 
  geom_bar(position="dodge", stat="identity",colour="black") + 
  facet_wrap(~Height)
plot1
gg_animate(plot1)
#Lets add in an transition animation based on species
plot1 + transition_states(
  Species,
  transition_length = 0.5,
  state_length = 0.5
)
plot1

