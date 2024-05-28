CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "ListExamples file found!"
else 
    echo "ListExamples file is missing! Cannot proceed."
    echo "Grade: 0"
    exit
fi 


cp TestListExamples.java student-submission/ListExamples.java grading-area
cp -r lib grading-area



cd grading-area
javac -cp $CPATH *.java


if [[ $? -eq 0 ]]
then
    echo "Compiled successfully!"
else
    echo "Compilation failed! Try looking through your code for possible errors!"
    exit
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep "Tests run" | cut -d ' ' -f3 | cut -d ',' -f1 > result.txt
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep "Failure" | cut -d ' ' -f6 > failures.txt
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-reults.txt
if [[ -s failures.txt ]]
then
    a=`cat result.txt`
    b=`cat failures.txt`
    echo "You failed some tests! You got a:  $(($a-$b)) out of $a"
    exit 
    
else
    echo "You passed all the tests! You got a 100% "
fi