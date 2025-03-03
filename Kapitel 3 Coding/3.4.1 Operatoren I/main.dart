void main(List<String> args) {
  aufg1();
  bonusAufg1();
}

void aufg1() {
  int a=6;
  int b=3*++a;
  int c=2*a++;
  double d=b/c;
  String e="$a";
  String f=a.toString();
  String g=e+f+f;
  bool h=a==b;
  assert(h==false);
  bool i=a!=b;
  assert(i==true);
  bool j=a>b;
  assert(j==false);
  bool k=f.length>(c*4000).toString().length;
  assert(k==false);
  bool l=g.length==c;
  assert(l==false);
  bool m=1<=--b;
  assert(m==true);
  bool n=g.length==(d>0.5);
  assert(n==false);
  List<int> o=[1,2,3]+[4,5,6];
  bool p=g[0]==(3+3).toString();
  assert(p==false);
  int q=o.first*o.last+o[1]-o.length;
  assert(q==2);

}

void bonusAufg1() {
  int a=42;
  int b=(5*++a+3)*(a---40);
  int c=(a++*3+2)*(++a-b~/10);
  double d=(b*1.5+c)/(a-b%c);
  String e="${a*2}${b~/10}";
  String f=(c*3+b~/5).toString();
  String g=e+f+d.toString();
  List<int> h=[1,2,3,4,5];
  h.add(a);
  h.addAll([7,8,9]);
  int i=h[h.length-2]*h[2]+h.first;
  String j=(a+10).toString()+(b~/100).toString();
  int k=h[4]*(c~/b)+h[2];
  assert(k==-17);
  List<int> l=[a,b,c];
  l.add(b~/10);
  l.add(c%100);
  String m=l[2].toString()+l[1].toString();
  int n=m.length*l.length+i;
  assert(n==65);
  bool o=g.length>m.length;
  assert(o==true);
  bool p=h[3]>l[2];
  assert(p==true);
  int q=(h.length+l.length)*(j.length-1);
  assert(q==28);

  print("2688/100=${2688~/100}, Rest ${2688%100}");
  print("-2688/100=${-2688~/100}, Rest ${-2688%100}");

  int quot = -2488;
  int divisor = 100;
  int erg = quot % divisor + (quot<0 ? -divisor : 0);
  
  print("C#-konformes Ergebnis: $erg");
  
} 