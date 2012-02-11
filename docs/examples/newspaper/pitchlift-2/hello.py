from tropo import Tropo
import web

urls = (
 '/', 'Index'
)

class Index:
    def POST(self):
        t = Tropo()
        t.say("Welcome to Tropo")
        return t.RenderJson()

app = web.application(urls, globals())

if __name__ == '__main__':
    app.run()
