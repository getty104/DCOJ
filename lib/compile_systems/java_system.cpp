#include <iostream>
#include <fstream>
using namespace std;

int main(int argc, char const *argv[])
{
  ofstream ofs;
  ofs.open("Main.java",ios::binary);
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
  system("/opt/wandbox/openjdk-head/jvm/openjdk-10-internal/bin/javac Main.java");
  system("/usr/bin/time -f '%U' /opt/wandbox/openjdk-head/jvm/openjdk-10-internal/bin/java Main < test.in");
  return 0;
}