#!/bin/bash

# Убедился бы на сколько мне важно, чтобы скрипт падал из-за ошибки
# Или выбпал бы участок, где мне важно это
# Или где не надо отлавливать использовал бы set +e для отключения и set -e  дял обратного включения возможности.
set -e

# Определяем переменные
OLD_FILE=/tmp/old
NEW_FILE=/tmp/new

# Проверка Не является OLD_FILE директорией и выдавать ошибку что файл не найден?
#if [ ! -d $OLD_FILE ] ; then
#	echo ERROR: file $OLD_FILE doesn't' exist
#	exit 1
#fi

if [[ ! -f $OLD_FILE ]]
then
  echo "$OLD_FILE - not file or file is absent"
  exit 1
fi

# Так пониаю удаление файла перед созданием
# лишняя строка, так как ниже мы все равно перезаписываем содержимое файла test > NEW_FILE
#[ -d $NEW_FILE ] && rm -f $NEW_FILE

# Проверка, пустой файл или нет
if [[ `cat $OLD_FILE` == "" ]] ;
	echo "$OLD_FILE file is empty"
	exit 1
else
  content=`cat $OLD_FILE`
fi

# Видимо чтение файла по строкам, не совсем понял  если честно ) или количество слов)
# но имя внутренней переменной line подсказало. что это строки )

# Может не сработать, в переменную Line могут прилететь не строки, а слова разделенные пробелами
# Если надо именно это, то ладно
# Если тут по словам, то можно так поправить
count=0
# Очищаем содержимое файл NEW,  а если его и не было - создаем пустой
for line in $content ; do
	new_file_content=$(echo -e "$new_file_content\n$count: $line")
	count=$(($count + 1))
done

# Добавлю свою два варианта, дял нумерации строк

# Если надо прям номер строки выводить, то так:
grep ^ -n $OLD_FILE.sh | sed 's/REAL_PASSWD/****/g' > $NEW_FILE

# Или через while - недавно столкнулся с подобной задачей
# Данный вариант начнет нумеровать со значения переменной count
count=0
while read line; do echo "$count: $line"; count=$(($count + 1)); done < $OLD_FILE | sed 's/REAL_PASSWD/****/g' > $NEW_FILE

# Может еще лучший вариант есть, но это первое пришлов голову ,чтобы сократить код
echo $new_file_content | sed 's/REAL_PASSWD/****/g' > $NEW_FILE

# не хорошо так делать, когда можно указать параметр -i  и тогда сразу запись в файл пойдет
##sed 's/REAL_PASSWD/****/g' $NEW_FILE > $NEW_FILE
# sed -i 's/REAL_PASSWD/****/g' $NEW_FILE