set -u
set -e

for i in {14..21}
do
  dexy gen -t "t$i" -d "d$i"
  cd "d$i"
  dexy
  cd ..
done
