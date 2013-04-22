# Will generate a world map with Goldenfields and Mountain Watch assuming
# there will be an exported png file in their respective directories.
convert -background black \
	../maps/mountainwatch/main.png \
	../maps/goldenfields/main.png \
	-append \
	world.png

gdal2tiles.py -p raster -z 0-6 -w none world.png data
