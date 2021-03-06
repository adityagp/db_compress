all: data_io.o utility.o model.o model_learner.o categorical_model.o numerical_model.o string_model.o compression.o decompression.o dbcompress.o

unit_test: data_io_test utility_test model_test model_learner_test categorical_model_test numerical_model_test string_model_test compression_test decompression_test test_run

clean :
	rm *.o byte_writer_test.txt compression_test.txt *_test

data_io.o : data_io.cpp data_io.h base.h
	g++ -std=c++11 -Wall -c data_io.cpp

utility.o : utility.cpp utility.h base.h
	g++ -std=c++11 -Wall -c utility.cpp

model.o : model.cpp model.h base.h
	g++ -std=c++11 -Wall -c model.cpp

model_learner.o : model_learner.cpp model.h base.h model_learner.h
	g++ -std=c++11 -Wall -c model_learner.cpp

categorical_model.o : categorical_model.cpp categorical_model.h base.h model.h utility.h
	g++ -std=c++11 -Wall -c categorical_model.cpp

numerical_model.o : numerical_model.cpp numerical_model.h base.h model.h utility.h
	g++ -std=c++11 -Wall -c numerical_model.cpp

string_model.o : string_model.cpp string_model.h base.h model.h
	g++ -std=c++11 -Wall -c string_model.cpp

compression.o : compression.cpp compression.h model.h model_learner.h base.h
	g++ -std=c++11 -Wall -c compression.cpp

decompression.o : decompression.cpp decompression.h model.h
	g++ -std=c++11 -Wall -c decompression.cpp

dbcompress.o : data_io.o utility.o model.o model_learner.o categorical_model.o numerical_model.o string_model.o compression.o decompression.o
	ld -r data_io.o utility.o model.o model_learner.o categorical_model.o numerical_model.o string_model.o compression.o decompression.o -o dbcompress.o

sample : sample.cpp data_io.o model.o model_learner.o categorical_model.o numerical_model.o string_model.o compression.o decompression.o utility.o
	g++ -std=c++11 -O3 -Wall data_io.o model.o model_learner.o categorical_model.o numerical_model.o string_model.o compression.o decompression.o utility.o sample.cpp -o sample

data_io_exec : data_io.o data_io_test.cpp
	g++ -std=c++11 -Wall data_io.o data_io_test.cpp -o data_io_test

data_io_test : data_io_exec
	./data_io_test

utility_exec : utility.o utility_test.cpp
	g++ -std=c++11 -Wall utility.o utility_test.cpp -o utility_test

utility_test : utility_exec
	./utility_test

categorical_model_exec : model.o categorical_model.o data_io.o utility.o categorical_model_test.cpp
	g++ -std=c++11 -Wall categorical_model.o data_io.o utility.o model.o categorical_model_test.cpp -o categorical_model_test

categorical_model_test : categorical_model_exec
	./categorical_model_test

numerical_model_exec : model.o numerical_model.o data_io.o utility.o numerical_model_test.cpp
	g++ -std=c++11 -Wall model.o numerical_model.o data_io.o utility.o numerical_model_test.cpp -o numerical_model_test

numerical_model_test : numerical_model_exec
	./numerical_model_test

string_model_exec : model.o string_model.o data_io.o utility.o string_model_test.cpp
	g++ -std=c++11 -Wall model.o string_model.o data_io.o utility.o string_model_test.cpp -o string_model_test

string_model_test : string_model_exec
	./string_model_test

model_learner_exec : model.o model_learner.o utility.o model_learner_test.cpp
	g++ -std=c++11 -Wall model.o model_learner.o utility.o model_learner_test.cpp -o model_learner_test

model_learner_test : model_learner_exec
	./model_learner_test

model_exec : model.o utility.o model_test.cpp
	g++ -std=c++11 -Wall model.o utility.o model_test.cpp -o model_test

model_test : model_exec
	./model_test

compression_exec : unit_test.h model.o model_learner.o data_io.o utility.o compression.o compression_test.cpp
	g++ -std=c++11 -Wall model.o model_learner.o data_io.o utility.o compression.o compression_test.cpp -o compression_test

compression_test : compression_exec
	./compression_test

decompression_exec : unit_test.h model.o data_io.o utility.o decompression.o decompression_test.cpp
	g++ -std=c++11 -Wall model.o data_io.o utility.o decompression.o decompression_test.cpp -o decompression_test

decompression_test : decompression_exec
	./decompression_test

test_run_exec : unit_test.h model.o model_learner.o data_io.o utility.o compression.o decompression.o test_run.cpp
	g++ -std=c++11 -Wall model.o model_learner.o data_io.o utility.o decompression.o compression.o test_run.cpp -o test_run

test_run : test_run_exec
	./test_run
