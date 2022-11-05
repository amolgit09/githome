import PyPDF2
import pandas as pd
from io import StringIO
from pdfminer. import extract_text_to_fp
from pdfminer.layout import LAParams
output = StringIO()
"""
reader = PyPDF2.PdfFileReader("C:\\Users\\DELL\\Downloads\\table.pdf")
text = ""
print(reader)

for page in reader.pages:
    #text += page.extractText() + "\n"
    #print(page.extract_text() + ";")
    for li in page.extract_text():
       print(li)
    #print(text)
"""