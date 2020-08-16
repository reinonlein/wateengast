import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import Qt


class Window(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Menu Widget")
        self.setGeometry(350,150,600,600)
        self.UI()

    def UI(self):
        ##########################Main Menu###############
        menubar=self.menuBar()
        file=menubar.addMenu("File")
        edit=menubar.addMenu("Edit")
        code=menubar.addMenu("Code")
        helpMenu=menubar.addMenu("Help")

        ###########################Sub Menu Items################
        new=QAction("New Project",self)
        new.setShortcut("Ctrl+O")
        file.addAction(new)
        open=QAction("Open",self)
        file.addAction(open)
        exit=QAction("Exit",self)
        exit.setIcon((QIcon("icons/exit.png")))
        exit.triggered.connect(self.exitFunc)
        file.addAction(exit)
        ################ToolBar###################
        tb=self.addToolBar("My Toolbar")
        tb.setToolButtonStyle(Qt.ToolButtonTextUnderIcon)
        newTb=QAction(QIcon('icons/folder.png'),"New",self)
        tb.addAction(newTb)
        openTb=QAction(QIcon('icons/empty.png'),"Open",self)
        tb.addAction(openTb)
        saveTb=QAction(QIcon('icons/save.png'),"Save",self)
        tb.addAction(saveTb)
        exitTb=QAction(QIcon('icons/exit.png'),"Exit",self)
        exitTb.triggered.connect(self.exitFunc)
        tb.addAction(exitTb)
        tb.actionTriggered.connect(self.btnFunc)
        self.combo =QComboBox()
        self.combo.addItems(["Spiderman","Superman","Batman"])
        tb.addWidget(self.combo)
        self.show()

    def exitFunc(self):
        mbox=QMessageBox.information(self,"Warning","Are you sure to exit?",QMessageBox.Yes|QMessageBox.No,QMessageBox.No)
        if mbox==QMessageBox.Yes:
            sys.exit()

    def btnFunc(self,btn):
        if btn.text()=="New":
            print("You clicked new button")
        elif btn.text() =="Open":
            print("You clicked open button")
        else:
            print("You clicked save button")

def main():
    App=QApplication(sys.argv)
    window = Window()
    sys.exit(App.exec_())

if __name__=='__main__':
    main()