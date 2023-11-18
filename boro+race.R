setwd(file.path("/Users/silas/workplace_R/", "stat605"))
library(RSQLite)
library(grid)
conn <- dbConnect(SQLite(), dbname = "mydatabase.db")

total_arrests_query <- "SELECT COUNT(*) AS total_arrests FROM nypd_arrests;"

boro_arrests_query <- "SELECT ARREST_BORO, COUNT(*) AS boro_count 
FROM nypd_arrests 
GROUP BY ARREST_BORO;"

boro_race_arrests_query <- "
SELECT ARREST_BORO, PERP_RACE, COUNT(*) AS boro_race_count 
FROM nypd_arrests 
GROUP BY ARREST_BORO, PERP_RACE;"

total_arrests_res <- dbSendQuery(conn, total_arrests_query)
total_arrests_df <- dbFetch(total_arrests_res)
dbClearResult(total_arrests_res)

boro_arrests_res <- dbSendQuery(conn, boro_arrests_query)
boro_arrests_df <- dbFetch(boro_arrests_res)
dbClearResult(boro_arrests_res)

boro_race_arrests_res <- dbSendQuery(conn, boro_race_arrests_query)
boro_race_arrests_df <- dbFetch(boro_race_arrests_res)
dbClearResult(boro_race_arrests_res)

dbDisconnect(conn)

#画图
boro_arrests <- boro_arrests_df$boro_count
boro_race_arrests <- boro_race_arrests_df$boro_race_count

#半径
total_radius <- 0.5
boro_radius <- boro_arrests * total_radius *2 / as.numeric(total_arrests_df * 2)
boro_NA_radius <- boro_race_arrests[1:3] * boro_radius[1] /  boro_arrests[1]
boro_B_radius <- boro_race_arrests[4:11] * boro_radius[2]  /  boro_arrests[2]
boro_K_radius <- boro_race_arrests[12:19] * boro_radius[3] /  boro_arrests[3]
boro_M_radius <- boro_race_arrests[20:27] * boro_radius[4] /  boro_arrests[4]
boro_Q_radius <- boro_race_arrests[28:35] * boro_radius[5] /  boro_arrests[5]
boro_S_radius <- boro_race_arrests[36:43] * boro_radius[6] /  boro_arrests[6]

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
grid.circle(x = boro_NA_radius[1]*2+boro_NA_radius[2]*2+boro_NA_radius[3], 
            y = 0.5, r = boro_NA_radius[3], 
            gp = gpar(fill = "#414c56", alpha = 1))
grid.circle(x = boro_NA_radius[1]*2+boro_NA_radius[2]*2+boro_NA_radius[3]*2+boro_NA_radius[4], 
            y = 0.5, r = boro_NA_radius[4], 
            gp = gpar(fill = "#a0a5ab", alpha = 1))
grid.circle(x = boro_NA_radius[1]*2+boro_NA_radius[2]*2+boro_NA_radius[3]*2+boro_NA_radius[4]*2+boro_NA_radius[5], 
            y = 0.5, r = boro_NA_radius[5], 
            gp = gpar(fill = "#e4abb1", alpha = 1))

#B
a1 <- boro_radius[1]*2
grid.circle(x = a1+boro_B_radius[1], 
            y = 0.5, r = boro_B_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2], 
            y = 0.5, r = boro_B_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3], 
            y = 0.5, r = boro_B_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3]*2+boro_B_radius[4], 
            y = 0.5, r = boro_B_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3]*2+boro_B_radius[4]*2+boro_B_radius[5], 
            y = 0.5, r = boro_B_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3]*2+boro_B_radius[4]*2+boro_B_radius[5]*2+boro_B_radius[6], 
            y = 0.5, r = boro_B_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3]*2+boro_B_radius[4]*2+boro_B_radius[5]*2+boro_B_radius[6]*2+boro_B_radius[7], 
            y = 0.5, r = boro_B_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a1+boro_B_radius[1]*2+boro_B_radius[2]*2+boro_B_radius[3]*2+boro_B_radius[4]*2+boro_B_radius[5]*2+boro_B_radius[6]*2+boro_B_radius[7]*2+boro_B_radius[8], 
            y = 0.5, r = boro_B_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#K
a2 <- boro_radius[1]*2+boro_radius[2]*2

grid.circle(x = a2+boro_K_radius[1], 
            y = 0.5, r = boro_K_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2], 
            y = 0.5, r = boro_K_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3], 
            y = 0.5, r = boro_K_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3]*2+boro_K_radius[4], 
            y = 0.5, r = boro_K_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3]*2+boro_K_radius[4]*2+boro_K_radius[5], 
            y = 0.5, r = boro_K_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3]*2+boro_K_radius[4]*2+boro_K_radius[5]*2+boro_K_radius[6], 
            y = 0.5, r = boro_K_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3]*2+boro_K_radius[4]*2+boro_K_radius[5]*2+boro_K_radius[6]*2+boro_K_radius[7], 
            y = 0.5, r = boro_K_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a2+boro_K_radius[1]*2+boro_K_radius[2]*2+boro_K_radius[3]*2+boro_K_radius[4]*2+boro_K_radius[5]*2+boro_K_radius[6]*2+boro_K_radius[7]*2+boro_K_radius[8], 
            y = 0.5, r = boro_K_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#M
a3 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2

grid.circle(x = a3+boro_M_radius[1], 
            y = 0.5, r = boro_M_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2], 
            y = 0.5, r = boro_M_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3], 
            y = 0.5, r = boro_M_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3]*2+boro_M_radius[4], 
            y = 0.5, r = boro_M_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3]*2+boro_M_radius[4]*2+boro_M_radius[5], 
            y = 0.5, r = boro_M_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3]*2+boro_M_radius[4]*2+boro_M_radius[5]*2+boro_M_radius[6], 
            y = 0.5, r = boro_M_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3]*2+boro_M_radius[4]*2+boro_M_radius[5]*2+boro_M_radius[6]*2+boro_M_radius[7], 
            y = 0.5, r = boro_M_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a3+boro_M_radius[1]*2+boro_M_radius[2]*2+boro_M_radius[3]*2+boro_M_radius[4]*2+boro_M_radius[5]*2+boro_M_radius[6]*2+boro_M_radius[7]*2+boro_M_radius[8], 
            y = 0.5, r = boro_M_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))


#Q
a4 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2

grid.circle(x = a4+boro_Q_radius[1], 
            y = 0.5, r = boro_Q_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2], 
            y = 0.5, r = boro_Q_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3], 
            y = 0.5, r = boro_Q_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3]*2+boro_Q_radius[4], 
            y = 0.5, r = boro_Q_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3]*2+boro_Q_radius[4]*2+boro_Q_radius[5], 
            y = 0.5, r = boro_Q_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3]*2+boro_Q_radius[4]*2+boro_Q_radius[5]*2+boro_Q_radius[6], 
            y = 0.5, r = boro_Q_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3]*2+boro_Q_radius[4]*2+boro_Q_radius[5]*2+boro_Q_radius[6]*2+boro_Q_radius[7], 
            y = 0.5, r = boro_Q_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a4+boro_Q_radius[1]*2+boro_Q_radius[2]*2+boro_Q_radius[3]*2+boro_Q_radius[4]*2+boro_Q_radius[5]*2+boro_Q_radius[6]*2+boro_Q_radius[7]*2+boro_Q_radius[8], 
            y = 0.5, r = boro_Q_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#S
a5 <- boro_radius[1]*2+boro_radius[2]*2+boro_radius[3]*2+boro_radius[4]*2+boro_radius[5]*2

grid.circle(x = a5+boro_S_radius[1], 
            y = 0.5, r = boro_S_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2], 
            y = 0.5, r = boro_S_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3], 
            y = 0.5, r = boro_S_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3]*2+boro_S_radius[4], 
            y = 0.5, r = boro_S_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3]*2+boro_S_radius[4]*2+boro_S_radius[5], 
            y = 0.5, r = boro_S_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3]*2+boro_S_radius[4]*2+boro_S_radius[5]*2+boro_S_radius[6], 
            y = 0.5, r = boro_S_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3]*2+boro_S_radius[4]*2+boro_S_radius[5]*2+boro_S_radius[6]*2+boro_S_radius[7], 
            y = 0.5, r = boro_S_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a5+boro_S_radius[1]*2+boro_S_radius[2]*2+boro_S_radius[3]*2+boro_S_radius[4]*2+boro_S_radius[5]*2+boro_S_radius[6]*2+boro_S_radius[7]*2+boro_S_radius[8], 
            y = 0.5, r = boro_S_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

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
colors = c("#fc6666", "#fca14d", "#fdf233", "#50c800", "#80fdf2", "#66b0fc", "#e499fd", "#aaaaaa")
labels = c("AI/AN", "A/PI", "BLK", "BLK HIS", "OTHER", "UNK", "WHT", "WHT HIS")

pushViewport(viewport(x = 0.54, y = 0.25, width = 0.3, height = 0.15))

for (i in 1:length(colors)) {
  grid.rect(x = 0.1, y = 1 - i * 0.2, width = 0.05, height = 0.05, gp = gpar(fill = colors[i], col = NA))
  grid.text(labels[i], x = 0.2, y = 1 - i * 0.2, just = "left")
}

# Exit the viewport
popViewport()

