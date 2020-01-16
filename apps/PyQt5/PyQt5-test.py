from PyQt5 import QtWidgets
from PyQt5.QtWidgets import QApplication, QMainWindow
import sys


def window():
    app = QApplication(sys.argv)
    win = QMainWindow()
    win.setGeometry(200, 200, 500, 400)
    win.setWindowTitle("Awesome eerste applicatie!")

    label = QtWidgets.QLabel(win)
    label.setText("Wat een briljant awesome label gast!")
    label.move(50,50)

    win.show()
    sys.exit(app.exec_())

window()

#in designer: pyuic5 -x designer-testje.ui -o designer-testje.py