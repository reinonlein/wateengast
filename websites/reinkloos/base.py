from flask import Flask, render_template

app = Flask(__name__)

app.name="Rein"

@app.route('/')
def home():
    return '<H1>hoi</H1>'

@app.route("/naam/<name>")
def naam(name):
    naam = name
    if naam[-1] == "y":
        naam = naam[:-1] + 'iful'
    else:
        naam = naam + 'y'
        
    return '<H1>Jouw verknipte naam is {}</H1>'.format(naam)



if __name__ == '__main__':
    app.run(debug=True)