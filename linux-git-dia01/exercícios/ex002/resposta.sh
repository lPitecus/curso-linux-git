 #!/bin/bash
cd /tmp/petcc/exercícios
mkdir ex002
cd ex002
mkdir mydir
cd mydir
touch mytext.txt
echo "Hello, World!" >> mytext.txt
cat mytext.txt
cp mytext.txt mytext_copy.txt
rm mytext.txt
ls
