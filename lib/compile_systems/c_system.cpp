#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char const *argv[])
{
  ofstream ofs;
  ofs.open("main.c",ios::binary);
  string buf;
  while(getline(cin,buf)){
    if(buf=="<$><*><$><*><$><*><$><*><$><*><$><*><$>")break;
    ofs<<buf<<endl;
  }
  ofs.close();
  ofs.open("test.in",ios::binary);
  while(getline(cin,buf)){
    ofs<<buf<<endl;
  }
  ofs.close();
  system("/opt/wandbox/gcc-head/bin/gcc main.c -o main -O2");
  system("/usr/bin/time -f '%U' ./main < test.in");
  return 0;
}