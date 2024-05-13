//
//  QAData.swift
//  RealEstate
//
//  Created by Ramzan on 11.05.2024.
//

import Foundation

struct QAData {
    let question: String
    let answer: String
}

let qaData: [QAData] = [
    QAData(question: "Какие  недвижимости вы предлагаете?", answer: "Мы предлагаем квартиры, дома, загородные участки и коммерческую недвижимость."),
    QAData(question: "В каких районах доступны ваши объекты?", answer: "Мы работаем с различными районами города и предлагаем недвижимость в различных районах."),
    QAData(question: "Какова средняя стоимость квартир в вашем портфолио?", answer: "Стоимость квартир в нашем портфолио варьируется в зависимости от района и характеристик объекта. Мы предлагаем разнообразные варианты, начиная от доступных до элитных квартир."),
    
    QAData(question: "Какие услуги вы предоставляете связанные с продажей недвижимости?", answer: "Мы помогаем с оценкой недвижимости, подготовкой документов, проведением показов объектов, организацией сделки и другими аспектами продажи."),
    QAData(question: "Есть ли у вас специальные предложения для первых покупателей?", answer: "Да, мы предлагаем специальные условия для первых покупателей, такие как скидки или бонусы."),
    QAData(question: "Могу ли я получить консультацию по выбору недвижимости?", answer: "Конечно, наши специалисты готовы помочь вам с выбором недвижимости, учитывая ваши предпочтения и бюджет."),
    QAData(question: "Какие документы мне понадобятся для покупки недвижимости?", answer: "Для покупки недвижимости вам потребуются паспорт и ИНН, а также дополнительные документы, зависящие от вида сделки."),
    QAData(question: "Сколько времени занимает процесс оформления сделки на покупку недвижимости?", answer: "Время оформления сделки может варьироваться, но обычно это занимает от нескольких недель до нескольких месяцев."),
    QAData(question: "Могу ли я ознакомиться с отчетом об оценке объекта?", answer: "Да, мы предоставляем отчет об оценке объекта перед заключением сделки."),
    QAData(question: "Какие варианты финансирования доступны для покупки недвижимости?", answer: "Мы сотрудничаем с различными банками и финансовыми учреждениями, которые могут предложить вам кредит на покупку недвижимости."),
    QAData(question: "Предоставляются ли гарантии на качество строительства?", answer: "Мы работаем только с проверенными застройщиками, предоставляющими гарантии на качество строительства."),
    QAData(question: "Каковы условия возврата денег, если я передумаю покупать недвижимость?", answer: "Условия возврата денег зависят от этапа сделки и заключенного договора. Мы рекомендуем обсудить этот вопрос с нашим менеджером."),

    QAData(question: "Можете ли вы помочь с оформлением ипотечного кредита?", answer: "Да, мы можем помочь вам с подбором программы ипотечного кредитования и подготовкой необходимых документов."),
    QAData(question: "как дела?", answer: "Да, мы можем помочь вам с подбором программы ипотечного кредитования и подготовкой необходимых документов."),
    QAData(question: "Как происходит оценка стоимости недвижимости?", answer: "Оценка стоимости недвижимости производится нашими экспертами на основе рыночной аналитики, состояния объекта и других факторов."),
      QAData(question: "Какие виды документов вы предоставляете при покупке недвижимости?", answer: "Мы предоставляем полный пакет документов, включая договор купли-продажи, акт приема-передачи и другие необходимые документы."),
      QAData(question: "Какие сроки сдачи объектов строительства?", answer: "Сроки сдачи объектов строительства указаны в договоре и зависят от конкретного проекта."),
      QAData(question: "Могу ли я посмотреть объекты недвижимости перед покупкой?", answer: "Да, мы организуем показы объектов недвижимости по вашему запросу."),
      QAData(question: "Какие дополнительные услуги вы предоставляете после покупки недвижимости?", answer: "После покупки недвижимости мы готовы предоставить услуги по дизайну интерьера, ремонту и другим видам поддержки."),
      QAData(question: "Какие документы нужны для оформления ипотеки?", answer: "Для оформления ипотеки вам понадобятся паспорт, ИНН, справка о доходах и другие документы, требуемые банком."),
      QAData(question: "Какие дополнительные расходы могут возникнуть при покупке недвижимости?", answer: "Дополнительные расходы могут включать налог на недвижимость, комиссию агентства по недвижимости и другие."),
      QAData(question: "Какие сроки получения ипотечного кредита?", answer: "Сроки получения ипотечного кредита зависят от банка и конкретных условий, но обычно это занимает несколько недель."),
      QAData(question: "Какие документы нужны для получения ипотечного кредита?", answer: "Для получения ипотечного кредита вам понадобятся паспорт, ИНН, справка о доходах и другие документы, требуемые банком."),
      QAData(question: "Есть ли у вас объекты с дополнительными возможностями (бассейн, спортивная площадка и т. д.)?", answer: "Да, у нас есть объекты с дополнительными возможностями, мы готовы подобрать под ваши требования."),
      QAData(question: "Какие способы оплаты вы принимаете?", answer: "Мы принимаем оплату наличными, банковским переводом, через системы электронных платежей и другие способы."),
      QAData(question: "Какие есть варианты страхования при покупке недвижимости?", answer: "Вы можете страховать недвижимость от различных рисков, таких как пожар, стихийные бедствия и другие."),
      QAData(question: "Какие документы нужны для страхования недвижимости?", answer: "Для страхования недвижимости вам понадобятся паспорт, данные о недвижимости и другие документы, зависящие от условий страхования."),
      QAData(question: "Какие сроки действия договора купли-продажи?", answer: "Сроки действия договора купли-продажи указываются в самом договоре и зависят от конкретных условий."),
      QAData(question: "Какие документы нужны для оформления договора аренды недвижимости?", answer: "Для оформления договора аренды недвижимости вам понадобятся паспорт, данные о недвижимости и другие документы, зависящие от условий аренды."),
      QAData(question: "Какие дополнительные расходы могут возникнуть при аренде недвижимости?", answer: "Дополнительные расходы при аренде недвижимости могут включать коммунальные услуги, комиссию агентства по недвижимости и другие."),
      QAData(question: "Могу ли я изменить условия договора после его заключения?", answer: "Изменение условий договора после его заключения возможно при согласии обеих сторон и в соответствии с законодательством."),
      QAData(question: "Как происходит регистрация договора купли-продажи недвижимости?", answer: "Регистрация договора купли-продажи недвижимости происходит в органах регистрации прав на недвижимое имущество и сделок с ними."),
    QAData(question: "Какие дополнительные расходы могут возникнуть при покупке недвижимости?", answer: "Дополнительные расходы могут включать налог на недвижимость, комиссию агентства по недвижимости, расходы на оценку и страхование."),
       QAData(question: "Какие документы нужны для получения кредита на покупку недвижимости?", answer: "Для получения кредита на покупку недвижимости вам понадобятся паспорт, ИНН, справка о доходах и другие документы, требуемые банком."),
       QAData(question: "Могу ли я погасить кредит раньше срока?", answer: "Да, вы можете погасить кредит раньше срока, но могут быть применены штрафные санкции в соответствии с условиями кредитного договора."),
       QAData(question: "Какие виды страхования предлагаете для покупки недвижимости?", answer: "Мы предлагаем страхование недвижимости от пожара, стихийных бедствий, кражи, а также страхование жизни и здоровья."),
       QAData(question: "Какие документы нужны для страхования недвижимости?", answer: "Для страхования недвижимости вам понадобятся паспорт, данные о недвижимости, а также дополнительные документы, зависящие от условий страхования."),
       QAData(question: "Какие условия аренды предлагаете для коммерческой недвижимости?", answer: "Мы предлагаем различные условия аренды коммерческой недвижимости, включая длительность аренды, условия оплаты и другие."),
       QAData(question: "Какие документы нужны для оформления аренды коммерческой недвижимости?", answer: "Для оформления аренды коммерческой недвижимости вам понадобятся паспорт, данные о недвижимости и другие документы, зависящие от условий аренды."),
       QAData(question: "Какие условия аренды предлагаете для загородной недвижимости?", answer: "Мы предлагаем различные условия аренды загородной недвижимости, включая срок аренды, условия оплаты и правила пользования."),
       QAData(question: "Какие документы нужны для оформления аренды загородной недвижимости?", answer: "Для оформления аренды загородной недвижимости вам понадобятся паспорт, данные о недвижимости и другие документы, зависящие от условий аренды."),
       QAData(question: "Какие условия аренды предлагаете для жилой недвижимости?", answer: "Мы предлагаем различные условия аренды жилой недвижимости, включая длительность аренды, условия оплаты и правила проживания."),
      

   
    // Добавьте остальные вопросы и ответы по мере необходимости
]





