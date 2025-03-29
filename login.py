import sys
import subprocess
from PySide6.QtWidgets import QApplication
from PySide6.QtQuick import QQuickView
from PySide6.QtCore import QUrl, Qt, QObject, Slot , QPoint

class Controller(QObject):
    def __init__(self, view):
        super().__init__()
        self.view = view
        self.dragging = False
        self.last_mouse_pos = None

    @Slot(float, float)
    def handle_mouse_press(self, x, y):
        self.dragging = True
        self.last_mouse_pos = (x, y)

    @Slot(float, float)
    def handle_mouse_move(self, x, y):
        if self.dragging:
            dx = x - self.last_mouse_pos[0]
            dy = y - self.last_mouse_pos[1]
            new_x = self.view.position().x() + dx
            new_y = self.view.position().y() + dy
            self.view.setPosition(QPoint(new_x, new_y))
            self.last_mouse_pos = (x, y)

    @Slot()
    def handle_mouse_release(self):
        self.dragging = False

    @Slot()
    def quit_application(self):
        QApplication.quit()

    @Slot()
    def open_new_application(self):
        subprocess.Popen(["python", "Dashboard.py"])
        self.quit_application()

app = QApplication(sys.argv)
view = QQuickView()
controller = Controller(view)

url = QUrl("login.qml")
view.setSource(url)

view.rootContext().setContextProperty("controller", controller)

view.setFlags(Qt.FramelessWindowHint | Qt.WindowTitleHint)
view.setColor(Qt.transparent)
view.show()
sys.exit(app.exec())