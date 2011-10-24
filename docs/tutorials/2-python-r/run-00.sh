set -u
set -e

cd ../docs/tutorials/2-python-r/00/

python run-prisoner.py
R CMD BATCH prisoner.R

# delete all generated files to clean up
# this also tests that they were created
rm dexy--hist.png
rm dexy--sim-output.csv
rm dexy--sim-params.json
rm dexy--sim-results.json
rm dexy--strategy-counts.png
rm prisoner.Rout
rm .RData
