setwd(file.path("/Users/silas/workplace_R/", "stat605"))
library(RSQLite)
library(grid)
conn <- dbConnect(SQLite(), dbname = "mydatabase.db")

total_arrests_query <- "SELECT COUNT(*) AS total_arrests FROM nypd_arrests;"

age_arrests_query <- "SELECT AGE_GROUP, COUNT(*) AS age_count 
FROM nypd_arrests WHERE AGE_GROUP IN ('45-64', '25-44', '18-24', '<18', '65+')
GROUP BY AGE_GROUP;"

age_race_arrests_query <- "
SELECT AGE_GROUP, PERP_RACE, COUNT(*) AS age_race_count 
FROM nypd_arrests WHERE AGE_GROUP IN ('45-64', '25-44', '18-24', '<18', '65+')
GROUP BY AGE_GROUP, PERP_RACE;"

total_arrests_res <- dbSendQuery(conn, total_arrests_query)
total_arrests_df <- dbFetch(total_arrests_res)
dbClearResult(total_arrests_res)

age_arrests_res <- dbSendQuery(conn, age_arrests_query)
age_arrests_df <- dbFetch(age_arrests_res)
dbClearResult(age_arrests_res)

age_race_arrests_res <- dbSendQuery(conn, age_race_arrests_query)
age_race_arrests_df <- dbFetch(age_race_arrests_res)
dbClearResult(age_race_arrests_res)

dbDisconnect(conn)

#画图
age_arrests <- age_arrests_df$age_count
age_race_arrests <- age_race_arrests_df$age_race_count

#半径
total_radius <- 0.5
age_radius <- age_arrests * total_radius *2 / as.numeric(total_arrests_df * 2)
race_18_24_radius <- age_race_arrests[1:8] * age_radius[1] /  age_arrests[1]
race_25_44_radius <- age_race_arrests[9:16] * age_radius[2]  /  age_arrests[2]
race_45_64_radius <- age_race_arrests[17:24] * age_radius[3] /  age_arrests[3]
race_65_radius <- age_race_arrests[25:32] * age_radius[4] /  age_arrests[4]
race_18_radius <- age_race_arrests[33:40] * age_radius[5] /  age_arrests[5]

grid.newpage()

#1st layer
grid.circle(x = 0.5, y = 0.5, r = total_radius, gp = gpar(fill = "#fdf9f3", alpha = 1))

#2nd layer
grid.circle(x = age_radius[1], 
            y = 0.5, r = age_radius[1], 
            gp = gpar(fill = "#bddbce", alpha = 1))
grid.circle(x = age_radius[1]*2+age_radius[2],                                                                                                                                         
            y = 0.5, r = age_radius[2], 
            gp = gpar(fill = "#bddbce", alpha = 1))
grid.circle(x = age_radius[1]*2+age_radius[2]*2+age_radius[3], 
            y = 0.5, r = age_radius[3], 
            gp = gpar(fill = "#bddbce", alpha = 1))
grid.circle(x = age_radius[1]*2+age_radius[2]*2+age_radius[3]*2+age_radius[4], 
            y = 0.5, r = age_radius[4], 
            gp = gpar(fill = "#bddbce", alpha = 1))
grid.circle(x = age_radius[1]*2+age_radius[2]*2+age_radius[3]*2+age_radius[4]*2+age_radius[5], 
            y = 0.5, r = age_radius[5], 
            gp = gpar(fill = "#bddbce", alpha = 1))
#3rd layer
#AMERICAN INDIAN/ALASKAN NATIVE

#18-24
grid.circle(x = race_18_24_radius[1], 
            y = 0.5, r = race_18_24_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2], 
            y = 0.5, r = race_18_24_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3], 
            y = 0.5, r = race_18_24_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3]*2+race_18_24_radius[4], 
            y = 0.5, r = race_18_24_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3]*2+race_18_24_radius[4]*2+race_18_24_radius[5], 
            y = 0.5, r = race_18_24_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3]*2+race_18_24_radius[4]*2+race_18_24_radius[5]*2+race_18_24_radius[6], 
            y = 0.5, r = race_18_24_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3]*2+race_18_24_radius[4]*2+race_18_24_radius[5]*2+race_18_24_radius[6]*2+race_18_24_radius[7], 
            y = 0.5, r = race_18_24_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = race_18_24_radius[1]*2+race_18_24_radius[2]*2+race_18_24_radius[3]*2+race_18_24_radius[4]*2+race_18_24_radius[5]*2+race_18_24_radius[6]*2+race_18_24_radius[7]*2+race_18_24_radius[8], 
            y = 0.5, r = race_18_24_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))
#25-44
a1 <- age_radius[1]*2
grid.circle(x = a1+race_25_44_radius[1], 
            y = 0.5, r = race_25_44_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2], 
            y = 0.5, r = race_25_44_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3], 
            y = 0.5, r = race_25_44_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3]*2+race_25_44_radius[4], 
            y = 0.5, r = race_25_44_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3]*2+race_25_44_radius[4]*2+race_25_44_radius[5], 
            y = 0.5, r = race_25_44_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3]*2+race_25_44_radius[4]*2+race_25_44_radius[5]*2+race_25_44_radius[6], 
            y = 0.5, r = race_25_44_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3]*2+race_25_44_radius[4]*2+race_25_44_radius[5]*2+race_25_44_radius[6]*2+race_25_44_radius[7], 
            y = 0.5, r = race_25_44_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a1+race_25_44_radius[1]*2+race_25_44_radius[2]*2+race_25_44_radius[3]*2+race_25_44_radius[4]*2+race_25_44_radius[5]*2+race_25_44_radius[6]*2+race_25_44_radius[7]*2+race_25_44_radius[8], 
            y = 0.5, r = race_25_44_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#45-64
a2 <- age_radius[1]*2+age_radius[2]*2
grid.circle(x = a2+race_45_64_radius[1], 
            y = 0.5, r = race_45_64_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2], 
            y = 0.5, r = race_45_64_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3], 
            y = 0.5, r = race_45_64_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3]*2+race_45_64_radius[4], 
            y = 0.5, r = race_45_64_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3]*2+race_45_64_radius[4]*2+race_45_64_radius[5], 
            y = 0.5, r = race_45_64_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3]*2+race_45_64_radius[4]*2+race_45_64_radius[5]*2+race_45_64_radius[6], 
            y = 0.5, r = race_45_64_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3]*2+race_45_64_radius[4]*2+race_45_64_radius[5]*2+race_45_64_radius[6]*2+race_45_64_radius[7], 
            y = 0.5, r = race_45_64_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a2+race_45_64_radius[1]*2+race_45_64_radius[2]*2+race_45_64_radius[3]*2+race_45_64_radius[4]*2+race_45_64_radius[5]*2+race_45_64_radius[6]*2+race_45_64_radius[7]*2+race_45_64_radius[8], 
            y = 0.5, r = race_45_64_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#65+
a3 <- age_radius[1]*2+age_radius[2]*2+age_radius[3]*2
grid.circle(x = a3+race_65_radius[1], 
            y = 0.5, r = race_65_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2], 
            y = 0.5, r = race_65_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3], 
            y = 0.5, r = race_65_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3]*2+race_65_radius[4], 
            y = 0.5, r = race_65_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3]*2+race_65_radius[4]*2+race_65_radius[5], 
            y = 0.5, r = race_65_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3]*2+race_65_radius[4]*2+race_65_radius[5]*2+race_65_radius[6], 
            y = 0.5, r = race_65_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3]*2+race_65_radius[4]*2+race_65_radius[5]*2+race_65_radius[6]*2+race_65_radius[7], 
            y = 0.5, r = race_65_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a3+race_65_radius[1]*2+race_65_radius[2]*2+race_65_radius[3]*2+race_65_radius[4]*2+race_65_radius[5]*2+race_65_radius[6]*2+race_65_radius[7]*2+race_65_radius[8], 
            y = 0.5, r = race_65_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))

#<18
a4 <- age_radius[1]*2+age_radius[2]*2+age_radius[3]*2+age_radius[4]*2
grid.circle(x = a4+race_18_radius[1], 
            y = 0.5, r = race_18_radius[1], 
            gp = gpar(fill = "#fc6666", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2], 
            y = 0.5, r = race_18_radius[2], 
            gp = gpar(fill = "#fca14d", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3], 
            y = 0.5, r = race_18_radius[3], 
            gp = gpar(fill = "#fdf233", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3]*2+race_18_radius[4], 
            y = 0.5, r = race_18_radius[4], 
            gp = gpar(fill = "#50c800", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3]*2+race_18_radius[4]*2+race_18_radius[5], 
            y = 0.5, r = race_18_radius[5], 
            gp = gpar(fill = "#80fdf2", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3]*2+race_18_radius[4]*2+race_18_radius[5]*2+race_18_radius[6], 
            y = 0.5, r = race_18_radius[6], 
            gp = gpar(fill = "#66b0fc", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3]*2+race_18_radius[4]*2+race_18_radius[5]*2+race_18_radius[6]*2+race_18_radius[7], 
            y = 0.5, r = race_18_radius[7], 
            gp = gpar(fill = "#e499fd", alpha = 1))
grid.circle(x = a4+race_18_radius[1]*2+race_18_radius[2]*2+race_18_radius[3]*2+race_18_radius[4]*2+race_18_radius[5]*2+race_18_radius[6]*2+race_18_radius[7]*2+race_18_radius[8], 
            y = 0.5, r = race_18_radius[8], 
            gp = gpar(fill = "#aaaaaa", alpha = 1))




#visual display
#text
pushViewport(viewport())

grid.text("18~24", x = 0.12, y = 0.65, gp = gpar(col = "black", fontsize = 12))
grid.text("25~44", x = 0.48, y = 0.75, gp = gpar(col = "black", fontsize = 14))
grid.text("45~64", x = 0.82, y = 0.61, gp = gpar(col = "black", fontsize = 12))
grid.text("65+", x = 0.92, y = 0.55, gp = gpar(col = "black", fontsize = 8))
grid.text("<18", x = 0.964, y = 0.55, gp = gpar(col = "black", fontsize = 8))

popViewport()

#label of race
colors = c("#fc6666", "#fca14d", "#fdf233", "#50c800", "#80fdf2", "#66b0fc", "#e499fd", "#aaaaaa")
labels = c("AI/AN", "A/PI", "BLK", "BLK HIS", "OTHER", "UNK", "WHT", "WHT HIS")

pushViewport(viewport(x = 0.56, y = 0.2, width = 0.3, height = 0.15))

for (i in 1:length(colors)) {
  grid.rect(x = 0.1, y = 1 - i * 0.2, width = 0.05, height = 0.05, gp = gpar(fill = colors[i], col = NA))
  grid.text(labels[i], x = 0.2, y = 1 - i * 0.2, just = "left")
}

# Exit the viewport
popViewport()


