﻿Функция ВыполнитьОбработкуПриложения(Запрос, Заголовки, ВозвращаемыеДанные, ПараметрыЗапроса, ДанныеТело) Экспорт	
	ИДПриложения = ПараметрыЗапроса.appid;
	НастройкиПриложения = леСерверПовтИсп.ПолучитьНастройкиПриложения(ИДПриложения);
	// todo все запросы необходимо переопределять в обработке
	Если ПараметрыЗапроса.Свойство("action") Тогда
		ВозвращаемыеДанные.action = ПараметрыЗапроса.action;
		ДанныеТело = Новый Структура;
		Если ПолучитьДанныеТелаЗапроса(Запрос, ДанныеТело) Тогда
			ТелоОтвета = "";			
			//Если ПараметрыЗапроса.action = "getstyle" Тогда					
			//	Макет = ПолучитьМакетРасширенная(Справочники.Страницы, ПараметрыЗапроса.stylename).ПолучитьТекст();					
			//	Обработки.ЗапросыКСерверу.ЗаполнитьНастройкиСайта(Макет, ИДПриложения);
			//	ВозвращаемыеДанные.data = Макет;
			//	ВозвращаемыеДанные.rawdata = Истина;										
			//	Заголовки.Вставить("Content-Type","text/css; charset=utf-8");
			//ИначеЕсли ПараметрыЗапроса.action = "getjs" Тогда					
			//	Макет = ПолучитьМакетРасширенная(Справочники.Страницы, ПараметрыЗапроса.jsname).ПолучитьТекст();
			//	Обработки.ЗапросыКСерверу.ЗаполнитьНастройкиСайта(Макет, ИДПриложения);				
			//	ВозвращаемыеДанные.data = Макет;
			//	ВозвращаемыеДанные.rawdata = Истина;
			//	Заголовки.Вставить("Content-Type", "application/javascript; charset=utf-8");
			//Иначе
				Результат = Ложь;
				//Обработчик = "Результат = Обработки."+НастройкиПриложения.ИмяОбработки+".ВыполнитьОбработкуПриложения(ВозвращаемыеДанные, ПараметрыЗапроса, ДанныеТело)";
				Обработчик = "Результат = Обработки.Обработка"+ПараметрыЗапроса.appid+".ВыполнитьОбработкуПриложения(ВозвращаемыеДанные, ПараметрыЗапроса, ДанныеТело)";
				Выполнить(Обработчик);
				ВозвращаемыеДанные.result = Результат;
				// todo заголовки необходимо переопределять в обработке
				Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");				
			//КонецЕсли;
		Иначе
			ВозвращаемыеДанные.result = Ложь;
			ВозвращаемыеДанные.data = ДанныеТело;
		КонецЕсли;
	//Иначе
	//	ВозвращаемыеДанные.data = СформироватьСтраницу(НастройкиПриложения.СтраницаПоУмолчанию, "", ПараметрыЗапроса);
	//	ВозвращаемыеДанные.rawdata = Истина;
	КонецЕсли;	
КонецФункции

Функция ДанныеТелаСодержатВсеОбязательныеПоля(ДанныеТело)
	Возврат Истина;
КонецФункции

Функция ПолучитьДанныеТелаЗапроса(Запрос, ДанныеТело)
	ТелоЗапроса = Запрос.ПолучитьТелоКакСтроку();
	ТелоЗапроса = РаскодироватьСтроку(ТелоЗапроса, СпособКодированияСтроки.КодировкаURL);	
	
	Если ЗначениеЗаполнено(ТелоЗапроса) и Лев(ТелоЗапроса, 1) = "{" Тогда
		Попытка
			Чтение = Новый ЧтениеJSON;
			Чтение.УстановитьСтроку(ТелоЗапроса);
			ДанныеТело = ПрочитатьJSON(Чтение,,,ФорматДатыJSON.ISO);
			
			Если ДанныеТелаСодержатВсеОбязательныеПоля(ДанныеТело) Тогда
				Возврат Истина;
			Иначе
				ДанныеТело = "В теле запроса заполнены не все обязательные поля";
				Возврат Ложь;
			КонецЕсли;
		Исключение
			ДанныеТело = ОписаниеОшибки();
			Возврат Ложь;
		КонецПопытки;
	Иначе
		Возврат Истина;
	КонецЕсли;	
КонецФункции
