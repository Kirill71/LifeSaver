
import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import SQLite
do{
    let server = HTTPServer()
    var table = ""
    let path = "/Users/Kirill21/Desktop/Project/stat.db"
    let db = try SQLite(path)
    defer{
        db.close()
    }
   
    var paramsJSON : String?
    var params:[String:String]?
    var routes = Routes()
    
    func execute()->String {
        var res:String = "<table id='table-id' cellpading='4' cellspasing='0'> <tr><th>id</th> <th>Status</th> <th>Pulse(p/m)</th> <th colspan = '2'> GPS - coordinate"
        do {
            try db.forEachRow(statement: "SELECT * FROM info") { (statement: SQLiteStmt, i:Int) -> () in
                res += " <tr>"
                let count = statement.columnCount()
                for i in 0 ..< count {
                    res += "<td>" + statement.columnText(position: i) + "</td>"
                }
                res += "</tr>"
            }}catch{
        }
        res += "</table>"
        print("Res" + res)
        return res
    }
    
    func insert()
    {  var createSQL = "DELETE FROM info"
        do
        {
            try  db.execute(statement: createSQL)
            createSQL = " INSERT INTO info (id,status,pulse,x,y) VALUES ";
            let temp = params?.sorted(by: <)
            var orderParam = [Int:String]()
            for obj in temp!
            {
                orderParam[Int(obj.key)!] = obj.value
            }
            for  i in 0..<((orderParam.count) - 1)
            {
                createSQL += "(\(i+1)," + orderParam[i+1]! + "),"
            }
            do
            {
                createSQL += "( \(orderParam.count)," + orderParam[orderParam.count]! + ")"
                try db.execute(statement: createSQL)
            }
            catch
            {
                print(db.errMsg())
            }
        }
        catch
        {
        print("Error!")
        }
    }
        routes.add(method:.post, uri: "/", handler:
        {
            request, response in
            print("request from mobile app")
            paramsJSON =  request.postBodyString
            do
            {
                params = try paramsJSON?.jsonDecode() as! [String : String]?
            }
            catch
            {
                print(" JSON not right")
            }
            insert()
            table = execute()

            response.completed()
    })

    
    
    
    routes.add(method:.get, uri: "/", handler:
        {request,response in
                    let startingPage = "<!DOCTYPE html>" +
                " <html lang='ru'>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<link rel='stylesheet' type='text/css' href='css/style.css'>" +
                " <link href='images/logo.ico' rel='shortcut icon' type='image/x-icon' >" +
                " <script src='js/voiceController.js' type='text/javascript'></script>" +
                "<script src='js/jquery-1.6.4.min.js' type='text/javascript'></script>" +
                "<script src='js/jquery.scrollTo-1.4.2-min.js' type='text/javascript'></script>" +
                "<script src='js/waypoints.min.js' type='text/javascript'></script>" +
                "<script src='js/navbar2.js' type='text/javascript'></script>" +
                " <script src='js/angular.js' type='text/javascript'></script>" +
                "<title>SoldierSaver</title>" +
                "</head>" +
                "<body>" +
                "<section id='home' name='home'>" +
                "<div class='main-menu section'>" +
                "<div class='menu'>" +
                "<ul>" +
                "<li><a href='home'>Главная</a></li>" +
                "<li><a href='#about'>Обо мне</a></li>" +
                "<li><a href='#program'>Статистика</a></li>" +
                "<li><a href='#contact'>Контакты</a></li>" +
                "</ul>" +
                "</div>" +
                "</div>" +
                "<div class='headerwrap'>" +
                "<div class='cascade'>" +
                "<div class='header'>" +
                "<h1>{soldierSaver}</h1>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</section>" +
                "<section id='about' name='about'>" +
                "<div class='about-main section'>" +
                "<div class='about'>" +
                "<h2>Обо мне</h2>" +
                "<img src='images/photo.png' class='photo-img'>" +
                "<div class='paragraph'>" +
                "<p>Привет всем. Меня зовут Кирилл Жаренков. Я родом из Украниы и проживаю в славном городе Харьков." +
                "Мне 20 лет, учусь в ХНУРЭ (Харьковкий национальный унивирситет радиоэлектронники). Веду здоровой образ жизни.</p>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</section>" +
                "<section id='program' name='program'>" +
                "<div class='program-main'>" +
                "<div class='program'>" +
                "<h2>Статистика</h2>" + table +
                "</div>" +
                "</div>" +
                "</section>" +
                "<section id='contact' name='contact'>" +
                "<div class='contact-main'>" +
                "<div class='contact'>" +
                "<h2>Контакты</h2>" +
                "<div id='w'>" +
                "<form id='contactform' name='contact' method='post' action='#'>" +
                "<div class='row'>" +
                "<label for='name'>Ваше Имя <span class='req'></span></label>" +
                "<input type='text' name='name' id='name' class='txt' tabindex='1' required>" +
                "</div>" +
                "<div class='row'>" +
                "<label for='email'>E-mail Адрес <span class='req'></span></label>" +
                "<input type='email' name='email' id='email' class='txt' tabindex='2'  required>" +
                "</div>" +
                "<div class='row'>" +
                "<label for='subject'>Тема <span class='req'></span></label>" +
                "<input type='text' name='subject' id='subject' class='txt' tabindex='3' required>" +
                "</div>" +
                "<div class='row'>" +
                "<label for='message'>Сообщение <span class='req'></span></label>" +
                "<textarea name='message' id='message' class='txtarea' tabindex='4' required></textarea>" +
                "</div>" +
                "<div class='center'>" +
                "<input type='submit' id='submitbtn' name='submitbtn' tabindex='5' value='Отправить'>" +
                "</div>" +
                "</form>" +
                "</div>" +
                "<div class='networks'>" +
                "<a href='https://www.facebook.com/profile.php?id=100010594450734'><img src='images/facebooklogo.png' class='facebook'></a>" +
                "<a href='https://vk.com/olegileto' ><img src='images/vk.png'></a>" +
                "<a href='https://github.com/olegileto' ><img src='images/gihub.png'></a>" +
                "<a href='https://mail.google.com/mail/u/0/#inbox' ><img src='images/googlogo.png'>/a>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "<div class='information'>" +
                "<p>KirillProduct corporation  ©<span> Design by<a href='https://vk.com/olegileto'> <i></i></a></ span></p>" +
                "</div>" +
                "</section>" +
                "</body>" +
            " </html>"

            response.setHeader(.contentType, value: "text/html")
            response.setBody(string: startingPage)
            response.completed()
    })
    
    server.addRoutes(routes)
    server.serverPort = 8181
    server.documentRoot = "./webroot"
    configureServer(server)
    
    do {
        // Launch the HTTP server.
        try server.start()
    } catch PerfectError.networkError(let err, let msg) {
        print("Network error thrown: \(err) \(msg)")
    }
}
catch{
    print("Error")
}
