
Hier even een kleine notitie aan mezelf. Dit zijn de stappen in de command line om een SQLITE-database op te zetten:

<ol>
    <li>set FLASK_APP=index.py</li>
    <li>flask db init</li>
    <li>flask db migrate -m "awesome message"</li>
    <li>flask db upgrade</li>
</ol>

Het Docker image haal je binnen vanuit de hub met:

docker pull reinonlein/reinonlein
(inloggen met docker login -u reinonlein)

daarna image runnen met docker run -d -p 5000:5000 reinonlein/reinonlein

maak image met docker build -t reinonlein/reinonlein:latest .