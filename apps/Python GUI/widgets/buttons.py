import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Using Labels")
        self.setGeometry(50,50,350,350)
        self.UI()


    def UI(self):
        self.text=QLabel("My Text",self)
        enterButon= QPushButton("Enter",self)
        exitButon= QPushButton("Exit",self)
        self.text.move(160,50)
        enterButon.move(100,80)
        exitButon.move(200,80)
        enterButon.clicked.connect(self.enterFunc)
        exitButon.clicked.connect(self.exitFunc)
        self.show()

    def enterFunc(self):
        self.text.setText("You clicked Enter")
        self.text.resize(150,20)
    def exitFunc(self):
        self.text.setText("You clicked Exit")
        self.text.resize(150,20)


def main():
    App = QApplication(sys.argv)
    window=Window()
    sys.exit(App.exec_())

if __name__ == '__main__':
    main()