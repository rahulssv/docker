import xml.etree.ElementTree as ET

# Abrir o arquivo TXT
with open("resultado.txt", "r") as f:
  lines = f.readlines()

# Criar a raiz do documento XML
root = ET.Element("root")

# Adicionar elementos XML para cada linha do arquivo TXT
for line in lines:
  element = ET.Element("item")
  element.text = line.strip()
  root.append(element)

# Salvar o documento XML
tree = ET.ElementTree(root)
tree.write("resultado.xml")