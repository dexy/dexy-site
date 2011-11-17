### @export "top"
""" Basic todo list using webpy 0.3 """
import web
import model

urls = (
    '/', 'Index',
    '/del/(\d+)', 'Delete'
)

render = web.template.render('templates', base='base')

### @export "index-class"
class Index:

    form = web.form.Form(
        web.form.Textbox('title', web.form.notnull,
            description="I need to:", size=75),
        web.form.Button('Add todo'),
    )

    ### @export "index-get"
    def GET(self):
        """ Show page """
        todos = model.get_todos()
        form = self.form()
        return render.index(todos, form)

    ### @export "index-post"
    def POST(self):
        """ Add new entry """
        form = self.form()
        if not form.validates():
            todos = model.get_todos()
            return render.index(todos, form)
        model.new_todo(form.d.title)
        raise web.seeother('/')

### @export "delete-class"
class Delete:

    def POST(self, id):
        """ Delete based on ID """
        id = int(id)
        model.del_todo(id)
        raise web.seeother('/')


### @export "app"
app = web.application(urls, globals())

if __name__ == '__main__':
    app.run()
