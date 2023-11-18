setwd(file.path("/Users/silas/workplace_R/", "stat605"))
library(RSQLite)
library(grid)
conn <- dbConnect(SQLite(), dbname = "mydatabase.db")

total_arrests_query <- "SELECT COUNT(*) AS total_arrests FROM nypd_arrests;"

boro_arrests_query <- "SELECT ARREST_BORO, COUNT(*) AS boro_count 
FROM nypd_arrests 
GROUP BY ARREST_BORO;"

boro_sex_arrests_query <- "
SELECT ARREST_BORO, PERP_SEX, COUNT(*) AS boro_sex_count 
FROM nypd_arrests 
GROUP BY ARREST_BORO, PERP_SEX;"

total_arrests_res <- dbSendQuery(conn, total_arrests_query)
total_arrests_df <- dbFetch(total_arrests_res)
dbClearResult(total_arrests_res)

boro_arrests_res <- dbSendQuery(conn, boro_arrests_query)
boro_arrests_df <- dbFetch(boro_arrests_res)
dbClearResult(boro_arrests_res)

boro_sex_arrests_res <- dbSendQuery(conn, boro_sex_arrests_query)
boro_sex_arrests_df <- dbFetch(boro_sex_arrests_res)
dbClearResult(boro_sex_arrests_res)

dbDisconnect(conn)

#画图
boro_arrests <- boro_arrests_df$boro_count
boro_sex_arrests <- boro_sex_arrests_df$boro_sex_count

#半径
total_radius <- 0.5
boro_radius <- boro_arrests * total_radius *2 / as.numeric(total_arrests_df * 2)
boro_NA_radius <- boro_sex_arrests[1:2] * boro_radius[1] /  boro_arrests[1]
boro_B_radius <- boro_sex_arrests[3:4] * boro_radius[2]  /  boro_arrests[2]
boro_K_radius <- boro_sex_arrests[5:6] * boro_radius[3] /  boro_arrests[3]
boro_M_radius <- boro_sex_arrests[7:8] * boro_radius[4] /  boro_arrests[4]
boro_Q_radius <- boro_sex_arrests[9:10] * boro_radius[5] /  boro_arrests[5]
boro_S_radius <- boro_sex_arrests[11:12] * boro_radius[6] /  boro_arrests[6]

grid.newpage()

#1st layer
grid.circle(x = 0.5, y = 0.5, r = total_radius, gp = gpar(fill = "#fdf9f3", alpha = 1))

#2nd layer
grid.circle(x = boro_radius[1], 
            y = 0.5, r = boro_radius[1], 
            gp = gpar(fill = "#faeeef", alpha = 1))
grid.circle(x = boro_radius[1]*2+boro_radius[2],                                                                                                                                         
            y = 0.5, r = boro_radius[2], 
            gp = gpar(fill = "#faeeef", alpha = 1))
grid.circle(x = boro_radius[1]*2+boro_radius[2]*2+boro_radius[3], 
            y = 0.5, r = boro_radius[3], 
            gp = gpar(fill = "#faeeef", alpha = 1))
grid.circle(x = boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4], 
            y = 0.5, r = boro_radius[4], 
            gp = gpar(fill = "#faeeef", alpha = 1))
grid.circle(x = boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2+boro_radius[5], 
            y = 0.5, r = boro_radius[5], 
            gp = gpar(fill = "#faeeef", alpha = 1))
grid.circle(x = boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2+boro_radius[5]*2+boro_radius[6], 
            y = 0.5, r = boro_radius[6], 
            gp = gpar(fill = "#faeeef", alpha = 1))
#3rd layer
#NA
grid.circle(x = boro_NA_radius[1], 
            y = 0.5, r = boro_NA_radius[1], 
            gp = gpar(fill = "#e4abb1", alpha = 1))
grid.circle(x = boro_NA_radius[1]*2+boro_NA_radius[2], 
            y = 0.5, r = boro_NA_radius[2], 
            gp = gpar(fill = "#d1a083", alpha = 1))

#B
a1 <- boro_radius[1]*2
grid.circle(x = a1+boro_B_radius[1], 
            y = 0.5, r = boro_B_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2], 
            y = 0.5, r = boro_B_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))

#K
a2 <- boro_radius[1]*2+boro_radius[2]*2

grid.circle(x = a2+boro_K_radius[1], 
            y = 0.5, r = boro_K_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2], 
            y = 0.5, r = boro_K_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))

#M
a3 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2

grid.circle(x = a3+boro_M_radius[1], 
            y = 0.5, r = boro_M_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2], 
            y = 0.5, r = boro_M_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))


#Q
a4 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2

grid.circle(x = a4+boro_Q_radius[1], 
            y = 0.5, r = boro_Q_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2], 
            y = 0.5, r = boro_Q_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))

#S
a5 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2+boro_radius[5]*2

grid.circle(x = a5+boro_S_radius[1], 
            y = 0.5, r = boro_S_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2], 
            y = 0.5, r = boro_S_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))

#visual display
#text
pushViewport(viewport())

grid.text("B", x = 0.11, y = 0.65, gp = gpar(col = "black", fontsize = 14))
grid.text("K", x = 0.37, y = 0.67, gp = gpar(col = "black", fontsize = 14))
grid.text("M", x = 0.65, y = 0.67, gp = gpar(col = "black", fontsize = 14))
grid.text("Q", x = 0.87, y = 0.62, gp = gpar(col = "black", fontsize = 14))
grid.text("S", x = 0.984, y = 0.54, gp = gpar(col = "black", fontsize = 8))

popViewport()

#label of race
colors = c("#fc6666", "#fca14d")
labels = c("FEMALE", "MALE")

pushViewport(viewport(x = 0.52, y = 0.15, width = 0.3, height = 0.15))

for (i in 1:length(colors)) {
  grid.rect(x = 0.1, y = 1 - i * 0.2, width = 0.05, height = 0.05, gp = gpar(fill = colors[i], col = NA))
  grid.text(labels[i], x = 0.2, y = 1 - i * 0.2, just = "left")
}

# Exit the viewport
popViewport()

