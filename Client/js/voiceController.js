



    var recognizer = new webkitSpeechRecognition();
// Ставим опцию, чтобы распознавание началось ещё до того, как пользователь закончит говорить
function voice() {
    

    recognizer.interimResults = true;
// Какой язык будем распознавать?
    recognizer.lang = 'ru-Ru';
// Используем колбек для обработки результатов
    recognizer.onresult = function (event) {
        var result = event.results[event.resultIndex];
        if (result.isFinal) {
            if (result[0].transcript == "home") {
                document.location.href = "#home";
            }
            if (result[0].transcript == "about me") {
                document.location.href = '#about';
            }
            if (result[0].transcript == "program") {
                document.location.href = '#program';
            }
            if (result[0].transcript == "contact") {
                document.location.href = '#contact';
            }

        }
    };
    recognizer.start();
}

var recognizer = new webkitSpeechRecognition();
// Ставим опцию, чтобы распознавание началось ещё до того, как пользователь закончит говорить
recognizer.interimResults = true;
// Какой язык будем распознавать?
recognizer.lang = 'ru-Ru';
// Используем колбек для обработки результатов
recognizer.onresult = function (event) {
    var result = event.results[event.resultIndex];
    if (result.isFinal)
    {
        if (result[0].transcript == "главная")
        {
            document.location.href = "#home";
        }
        if (result[0].transcript == "обо мне" )
        {
            document.location.href = '#about';
        }
        if (result[0].transcript == "статистика")
        {
            document.location.href = '#program';
        }
        if (result[0].transcript == "контакты")
        {
            document.location.href = '#contact';
        }

    }
};
recognizer.start();
