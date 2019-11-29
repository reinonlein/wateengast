
Hier even een kleine notitie aan mezelf. Dit zijn de stappen in de command line om een SQLITE-database op te zetten:

<ol>
    <li>set FLASK_APP=index.py</li>
    <li>flask db init</li>
    <li>flask db migrate -m "awesome message"</li>
    <li>flask db upgrade</li>
</ol>