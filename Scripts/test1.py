import tabula
# Read a PDF File
df = tabula.read_pdf("C:\\Users\\DELL\\Downloads\\table.pdf", pages='all')[0]
# convert PDF into CSV
tabula.convert_into("C:\\Users\\DELL\\Downloads\\table.pdf", "test.csv",output_format="csv", pages='all')
#print(df)
#print(df[1])