# Приложение - Тестовое задание от LINGUALEO
Ниже представлены скриншоты выполненного мной приложения на Swift (UIKit):


<img width="245" alt="Снимок экрана 2023-08-12 в 00 58 12" src="https://github.com/Tyshkan4ik/LINGUALEO/assets/122968178/efb9d249-e47b-4746-af8c-006e78092744">
<img width="245" alt="Снимок экрана 2023-08-12 в 00 58 31" src="https://github.com/Tyshkan4ik/LINGUALEO/assets/122968178/0db90aa6-ea09-434c-b1a2-5fc518990122">
<img width="245" alt="Снимок экрана 2023-08-12 в 00 58 42" src="https://github.com/Tyshkan4ik/LINGUALEO/assets/122968178/685dd59a-204a-4775-af93-a6707cbf6862">
<img width="245" alt="Снимок экрана 2023-08-12 в 00 59 38" src="https://github.com/Tyshkan4ik/LINGUALEO/assets/122968178/ac4ab8d6-de66-44d1-917a-9f511cae601c">
<img width="245" alt="Снимок экрана 2023-08-12 в 00 59 58" src="https://github.com/Tyshkan4ik/LINGUALEO/assets/122968178/54d26b0d-cd39-4dcf-beec-7e4fd7b2ae4e">

## Текст задания:

Сверстать 2 экрана с произвольным UI, используя UIKit и верстку кодом без сторибордов. 

Архитектура - MVVM. Во главе стоит UINavigationController, навигация по средствам pushViewController.

На первом экране должен быть список игроков (игроки отсортированы по странам, внутри каждой страны - сортировка по набранным очкам). 

Каждое поле списка должно содержать следующие данные (name, score). Будет плюсом, если каждую страну получится выделить заголовком.

Второй экран - детальная информация об игроке. В верхней части указаны name, country, age; в нижней - level, score. А также кнопка удаления юзера, по нажатию на которую будет удаляться юзер из общего списка на время сессии приложения и будет происходить возврат на первый экран.

Данные по игрокам приложены в виде json-файла, который необходимо обработать непосредственно в проекте.
