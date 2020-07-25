library(magick)
library(magrittr)

newlogo <- image_scale(image_read("/home/prdm0/Downloads/criando_animacao/desenho.jpg"))
oldlogo <- image_scale(image_read("/home/prdm0/Downloads/criando_animacao/real.png"))
image_resize(c(oldlogo, newlogo), '1500x480!') %>%
  image_background('white') %>%
  image_morph() %>%
  image_animate(fps = 3, loop = 1L, optimize = TRUE, delay = 1/2)