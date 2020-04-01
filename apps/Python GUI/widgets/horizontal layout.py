import sys
from PyQt5.QtWidgets import *


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Horizontal Box Layout")
        self.setGeometry(350,150,400,400)
        self.UI()

    def UI(self):
        hbox=QHBoxLayout()
        button1=QPushButton("Button1",self)
        button2=QPushButton("Button2")
        button3=QPushButton("Button3")
        hbox.addStretch()
        hbox.addWidget(button1)
        hbox.addWidget(button2)
        hbox.addWidget(button3)
        hbox.addStretch()
        self.setLayout(hbox)
        self.show()


def main():
    App=QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__=='__main__':
    main()