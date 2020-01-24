import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Using Radio Buttons")
        self.setGeometry(250,150,500,500)
        self.UI()


    def UI(self):
        self.name=QLineEdit(self)
        self.name.move(150,50)
        self.name.setPlaceholderText("Enter your name")
        self.surname=QLineEdit(self)
        self.surname.move(150,80)
        self.surname.setPlaceholderText("Enter your surname")
        self.male=QRadioButton("Male",self)
        self.male.setChecked(True)
        self.female=QRadioButton("Female",self)
        self.male.move(150,110)
        self.female.move(200,110)
        button=QPushButton("Submit",self)
        button.clicked.connect(self.getValues)
        button.move(200,140)


        self.show()
    def getValues(self):
        name=self.name.text()
        surname=self.surname.text()
        if self.male.isChecked():
            print(name+" "+ surname+" You are a male")
        else:
            print(name + " " + surname + " You are a female")


def main():
    App = QApplication(sys.argv)
    window=Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()