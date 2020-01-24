import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Using LineEdits")
        self.setGeometry(50,50,350,350)
        self.UI()


    def UI(self):
        self.nameTextBox=QLineEdit(self)
        self.nameTextBox.setPlaceholderText("Please Enter your name")
        self.nameTextBox.move(120,50)
        self.passTextBox=QLineEdit(self)
        self.passTextBox.setPlaceholderText("Please Enter Your Password")
        self.passTextBox.setEchoMode(QLineEdit.Password)
        self.passTextBox.move(120,80)
        button=QPushButton("Save",self)
        button.move(180,110)
        button.clicked.connect(self.getValues)
        self.show()

    def getValues(self):
        name=self.nameTextBox.text()
        password=self.passTextBox.text()
        self.setWindowTitle("Your name is : "+name+ "Your Password is :"+password)


def main():
    App = QApplication(sys.argv)
    window=Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()