student(stud01, 'Programming 1', 90).
student(stud01, 'Math 1', 78).
student(stud01, 'Statistics 1', 94).
student(stud01, 'Electronics 1', 81).
student(stud01, 'Management', 66).
student(stud01, 'English', 83).
student(stud02, 'OS 1', 65).
student(stud02, 'Math 1', 50).
student(stud02, 'Data Communication', 76).
student(stud03, 'OOP', 68).
student(stud03, 'Math 1', 63).
student(stud03, 'Statistics 1', 98).
student(stud03, 'Electronics 2', 72).
student(stud04, 'Database', 59).
student(stud04, 'Math 3', 67).
student(stud04, 'Data Structures', 79).
student(stud05, 'Programming 1', 88).
student(stud05, 'Math 1', 75).
student(stud05, 'Statistics 1', 96).
student(stud05, 'Electronics 1', 89).
student(stud05, 'Management', 84).
student(stud06, 'Robotics', 62).
student(stud07, 'Programming 1', 50).
student(stud07, 'Math 2', 8).
student(stud07, 'Statistics 2', 70).
student(stud07, 'Electronics 1', 47).
student(stud08, 'OS 1', 71).
student(stud09, 'Robotics', 29).
student(stud09, 'Database', 57).
student(stud10, 'Data Structures', 82).
student(stud10, 'Math 2', 64).
student(stud10, 'Data Communication', 85).
student(stud10, 'Database', 46).
student(stud10, 'Electronics 2', 58).
student(stud10, 'Statistics 2', 97).
%
prerequisite('Programming 1', 'OOP').
prerequisite('OOP', 'OS 1').
prerequisite('OS 1', 'OS 2').
prerequisite('OOP', 'Data Structures').
prerequisite('Data Structures', 'Algorithms').
prerequisite('Algorithms', 'Advanced Algorithms').
prerequisite('Math 1', 'Math 2').
prerequisite('Math 2', 'Math 3').
prerequisite('Math 3', 'Math 4').
prerequisite('Statistics 1', 'Statistics 2').
prerequisite('Electronics 1', 'Electronics 2').
prerequisite('Electronics 2', 'Computer Architecture').
prerequisite('Computer Architecture', 'Microprocessors').
prerequisite('Data Communication', 'Networks').
prerequisite('Database', 'Data Warehouses').

%Helper Function
myAppend([],T2,T2).
myAppend(T2,[],T2).
myAppend([H|T], L2, [H|NT]):-
	myAppend(T, L2, NT).

%Helper Function
myMember(N,[N|_]).
myMember(N,[_|T]):-
	myMember(N,T).

%Helper Function
myReverse([],[]).
myReverse([H|T], R):-
    myReverse(T, RT),
    myAppend(RT, [H], R).

%Task 1
studentsInCourse(C,R):-
	studentsInCourse(C,[],R).
studentsInCourse(C,T,R):-
	student(S,C,G),
	not(myMember([S,G],T)),!,
	myAppend([[S,G]],T,NewT),
	studentsInCourse(C,NewT,R).

studentsInCourse(_,C,R):-
	myReverse(C,R).

%Task 2
numStudents(C,N):-
	numStudents(C,[],N).
numStudents(C,T,N):-
      student(S,C,_),
      not(myMember(S,T)),!,
      myAppend([S],T,NewT),
      numStudents(C,NewT,NewN),
      N is NewN+1.
numStudents(_,_,0).

%Helper Function
myMax([X],X).
myMax([X|Xs], M):-
	myMax(Xs, M),
	M >= X.
myMax([X|Xs], X):-
	myMax(Xs, M),
	X >  M.

%Task 3
maxStudentGrade(S,G):-
	maxStudentGrade(S,[],G).
maxStudentGrade(S,T,G):-
	student(S,_,Gr),
	not(myMember(Gr,T)),!,
	myAppend([Gr],T,NewT),
	maxStudentGrade(S,NewT,G).
maxStudentGrade(_,R,G):-
	myMax(R,NewG),
	G is NewG.

%Needed Predicates
myNumber(0,'zero').
myNumber(1,'one').
myNumber(2,'two').
myNumber(3,'three').
myNumber(4,'four').
myNumber(5,'five').
myNumber(6,'six').
myNumber(7,'seven').
myNumber(8,'eight').
myNumber(9,'nine').

%Helper Function
myNum(N,L):-
	N<10,
	myNumber(N,W),
	L=[W].
myNum(N,L):-
    N>9,N<99,
    H1 is N//10,
    T1 is N mod 10,
    myNumber(H1,H),
    myNumber(T1,T),
    L =[H,T].
myNum(N,L):-
    N>99,
    H1 is N//100,
    T1 is N // 10,
    T2 is T1 mod 10,
    T3 is N mod 10,
    myNumber(H1,H),
    myNumber(T2,M),
    myNumber(T3,T),
    L =[H,M,T].

%Task 4
gradeInWords(S,C,G):-
	student(S,C,G1),
	myNum(G1,G).
%
prequisiteCourses(C,L):-
	prequisiteCourses(C,[],L).
prequisiteCourses(C,T,R):-
	prerequisite(P,C),
	not(myMember(P,T)),!,
	myAppend([P],T,NewT),
	prequisiteCourses(P,NewT,R).
prequisiteCourses(_,R,R).
%
passedStudentCourses(S,R):-
	passedStudentCourses(S,[],R).
passedStudentCourses(S,T,R):-
	student(S,C,G),
	G >=50,
	not(myMember(C,T)),!,
	myAppend([C],T,NewT),
	passedStudentCourses(S,NewT,R).

passedStudentCourses(_,C,R):-
	myReverse(C,R).

%Helper Fuction
myCompare([],[]):-
	false.
myCompare([H|_],List):-
	myMember(H,List) , !.
myCompare([H|T],List):-
	not(myMember(H,List)) ,
	myCompare(T,List).

%Helper Fuction
extractDiff([H|T],L2,L,R):-
	not(myMember(H,L2)),
	myAppend([H],L,NewL),
	extractDiff(T,L2,NewL,R).
extractDiff([_|T],L2,L,R):-
        extractDiff(T,L2,L,R).
extractDiff([],_,L,L).

%Task 5
remainingCourses(S,C, L):-
	prequisiteCourses(C,LC1),
	passedStudentCourses(S,LC2),
	myCompare(LC1,LC2),
	extractDiff(LC1,LC2,[],NewL),
	myReverse(NewL,L).

%End


