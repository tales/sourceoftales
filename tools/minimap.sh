#convert $1 -sepia-tone 75% $2
#convert $1 \( +clone -sepia-tone 30% \) -average  $2
convert $1 \( +clone -sepia-tone 90% \) -average -darken 10% -alpha off $2
