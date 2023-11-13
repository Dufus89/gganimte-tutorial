#install gganimate
install.packages("gganimate")
#install gifski
install.packages("gifski")
#load gganimate, gifski, and other packages
library("gganimate")
library("gifski")
library("dplyr")
#load example data titled "Snake perch leaving"
Perch <- read.csv("Snake perch leaving.csv")
Lunges <- read.csv("Lunge snout tracking.csv")
#Lets a create a plot that shows the number of snakes of each species that left the perch at each of the height and target conditions.
plot1 <- ggplot(Perch, aes(x = Target,
                          y = Left.the.perch,
                          fill = Species)) +
  geom_bar(position="dodge", 
           stat="identity",colour="black") + facet_wrap(~Height) + 
  ggtitle("Experiment 1: snakes that left the perch ") +
  xlab("Target conditions") + ylab("Number of snakes ") + 
  labs(fill="Species") + 
  scale_fill_manual(values=c("#00FF00","#964B00")) + 
  theme_bw()+theme(plot.title = element_text(hjust = 0.5))
plot1 + theme(panel.grid.major = element_blank(),
               panel.grid.minor = element_blank())

#Trying to animate a plot with gg_animate will return an error due to this function not being supported
gg_animate(plot1)
#Instead gganimate uses functions
#for example 1: Lets add in an transition animation based on species using the transition_states function
Plot1_animated1 <- plot1 + transition_states(
  Species,
  transition_length = 0.1,
  state_length = 0.1
)
#Call option1: The plot should be animated and called forth by accessing the plot
Plot1_animated1
#Call option2: If that doesn't work then use the animate and gifski_renderer functions of the gifski package to render previously made plot into a gif
animate(Plot1_animated1, renderer = gifski_renderer())
#Lets add  another function of to our animated plot
#for example 2: shadow_wake
Plot1_animated2 <- plot1 + transition_states(
  Species,
  transition_length = 0.1,
  state_length = 0.1
) + shadow_wake(
  wake_length = 0.1, alpha = FALSE)
#Call option1
Plot1_animated2
#Call option2
animate(Plot1_animated2, renderer = gifski_renderer())
#Let add a more semeless transition
#example 3: fade and shrink
Plot1_animated3 <- plot1 + transition_states(
  Species,
  transition_length = 2,
  state_length = 1
) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')
#Call option1
Plot1_animated3
#Call option2
animate(Plot1_animated3, renderer = gifski_renderer())
#Lets create a line plot and try some animations on it
plot2 <- ggplot(data=Lunges, aes(x=Frame_number, y=Data, group=Snake_ID)) +
  geom_line(aes(color=Species))+scale_color_manual(values=c("#00FF00","#964B00")) + 
  theme_bw()+theme(plot.title = element_text(hjust = 0.5)) + 
  ggtitle("Experiment 1 snout tracking: lunge behavior") + 
  xlab("Frame number") + ylab("Y-coordinate data")
plot2
#example 3: Transition_reveal x-axis
Plot1_animated4 <- plot2 + geom_point() + transition_reveal(Frame_number)
#Call option1
Plot1_animated4
#Call option2
animate(Plot1_animated4, renderer = gifski_renderer())


