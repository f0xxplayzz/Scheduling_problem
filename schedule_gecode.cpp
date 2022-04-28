#include <gecode/int.hh>
#include <gecode/search.hh>
#include <gecode/minimodel.hh>

using namespace Gecode;

class Schedule : public Space {
protected:
	IntVarArray lectures;
	IntVarArray rooms;
public:
	Schedule(void) : lectures(*this, 21, 1, 15), rooms(*this, 21, 1, 5) {
		IntVar db2(lectures[0]), 
			its(lectures[1]), 
			ki(lectures[2]), 
			lp(lectures[3]),
			fp(lectures[4]), 
			aswe(lectures[5]), 
			sv(lectures[6]), 
			db1(lectures[7]), 
			tinf3(lectures[8]), 
			swe(lectures[9]), 
			m2(lectures[10]), 
			p2(lectures[11]),
			ra(lectures[12]), 
			bs(lectures[13]), 
			dt(lectures[14]), 
			tinf1(lectures[15]),
			m1(lectures[16]),
			p1(lectures[17]), 
			vla(lectures[18]),
			we(lectures[19]),
			bwl(lectures[20]);

		IntVarArray tinf2019(*this, 7, 1, 15);
		tinf2019[0] = db2;
		tinf2019[1] = its;
		tinf2019[2] = ki;
		tinf2019[3] = lp;
		tinf2019[4] = fp;
		tinf2019[5] = aswe;
		tinf2019[6] = sv;

		IntVarArray tinf2020(*this, 7, 1, 15);
		tinf2020[0] = db1;
		tinf2020[1] = tinf3;
		tinf2020[2] = swe;
		tinf2020[3] = m2;
		tinf2020[4] = p2;
		tinf2020[5] = ra;
		tinf2020[6] = bs;

		IntVarArray tinf2021(*this, 7, 1, 15);
		tinf2021[0] = dt;
		tinf2021[1] = tinf1;
		tinf2021[2] = m1;
		tinf2021[3] = p1;
		tinf2021[4] = vla;
		tinf2021[5] = we;
		tinf2021[6] = bwl;

		IntVarArray a(*this, 2, 1, 15);
		a[0] = db1;
		a[1] = db2;

		IntVarArray b(*this, 4, 1, 15);
		b[0] = tinf1;
		b[1] = ki;
		b[2] = lp;
		b[3] = aswe;

		IntVarArray c(*this, 3, 1, 15);
		c[0] = fp;
		c[1] = tinf3;
		c[2] = p1;

		IntVarArray d(*this, 2, 1, 15);
		d[0] = we;
		d[1] = bwl;

		IntVarArray e(*this, 2, 1, 15);
		e[0] = swe;
		e[1] = p2;

		IntVarArray g(*this, 3, 1, 15);
		g[0] = ra;
		g[1] = bs;
		g[2] = dt;

		IntVarArray h(*this, 2, 1, 15);
		h[0] = its;
		h[1] = sv;

		IntVarArray i(*this, 2, 1, 15);
		i[0] = m1;
		i[1] = m2;

		distinct(*this, tinf2019);
		distinct(*this, tinf2020);
		distinct(*this, tinf2021);

		distinct(*this, a);
		distinct(*this, b);
		distinct(*this, c);
		distinct(*this, d);
		distinct(*this, e);
		distinct(*this, g);
		distinct(*this, h);
		distinct(*this, i);

		IntVarArray roomHelper(*this, 21);
		IntVarArray dayHelper(*this, 21, 0, 4);

		IntVarArray dayHelper19(*this, 7);
		IntVarArray dayHelper20(*this, 7);
		IntVarArray dayHelper21(*this, 7);

		IntVarArray daysB(*this, 4, 1, 15);
		IntVarArray daysC(*this, 3, 1, 15);
		IntVarArray daysG(*this, 3, 1, 15);

		for (int loop = 0; loop < 21; loop++) {
			roomHelper[loop] = expr(*this, lectures[loop] + rooms[loop] * 15);
			dayHelper[loop] = expr(*this, (lectures[loop] - 1) / 3);
			if (loop < 7) {
				dayHelper19[loop] = dayHelper[loop];
			}
			else if (loop < 14) {
				dayHelper20[loop - 7] = dayHelper[loop];
			}
			else if (loop < 21) {
				dayHelper21[loop - 14] = dayHelper[loop];
			}
		}

		daysB[0] = dayHelper[2];
		daysB[1] = dayHelper[3];
		daysB[2] = dayHelper[5];
		daysB[3] = dayHelper[15];

		daysC[0] = dayHelper[4];
		daysC[1] = dayHelper[8];
		daysC[2] = dayHelper[17];

		daysG[0] = dayHelper[12];
		daysG[1] = dayHelper[13];
		daysG[2] = dayHelper[14];

		count(*this, dayHelper19, 0, IRT_GQ, 1); 
		count(*this, dayHelper19, 1, IRT_GQ, 1);
		count(*this, dayHelper19, 2, IRT_GQ, 1); 
		count(*this, dayHelper19, 3, IRT_GQ, 1); 
		count(*this, dayHelper19, 4, IRT_GQ, 1); 

		count(*this, dayHelper20, 0, IRT_GQ, 1); 
		count(*this, dayHelper20, 1, IRT_GQ, 1); 
		count(*this, dayHelper20, 2, IRT_GQ, 1); 
		count(*this, dayHelper20, 3, IRT_GQ, 1);
		count(*this, dayHelper20, 4, IRT_GQ, 1); 

		count(*this, dayHelper21, 0, IRT_GQ, 1); 
		count(*this, dayHelper21, 1, IRT_GQ, 1); 
		count(*this, dayHelper21, 2, IRT_GQ, 1); 
		count(*this, dayHelper21, 3, IRT_GQ, 1); 
		count(*this, dayHelper21, 4, IRT_GQ, 1); 

		count(*this, daysB, 0, IRT_LQ, 2);
		count(*this, daysB, 1, IRT_LQ, 2); 
		count(*this, daysB, 2, IRT_LQ, 2); 
		count(*this, daysB, 3, IRT_LQ, 2);
		count(*this, daysB, 4, IRT_LQ, 2); 

		count(*this, daysC, 0, IRT_LQ, 2); 
		count(*this, daysC, 1, IRT_LQ, 2); 
		count(*this, daysC, 2, IRT_LQ, 2);
		count(*this, daysC, 3, IRT_LQ, 2); 
		count(*this, daysC, 4, IRT_LQ, 2); 

		count(*this, daysG, 0, IRT_LQ, 2);
		count(*this, daysG, 1, IRT_LQ, 2); 
		count(*this, daysG, 2, IRT_LQ, 2); 
		count(*this, daysG, 3, IRT_LQ, 2); 
		count(*this, daysG, 4, IRT_LQ, 2); 
		
		distinct(*this, roomHelper);

		branch(*this, lectures, INT_VAR_SIZE_MIN(), INT_VAL_MIN());
		branch(*this, rooms, INT_VAR_SIZE_MIN(), INT_VAL_MIN());
	}

	Schedule(Schedule& s) : Space(s) {
		lectures.update(*this, s.lectures);
		rooms.update(*this, s.rooms);
	}

	virtual Space* copy(void) {
		return new Schedule(*this);
	}

	void print(void) const {
		std::cout << lectures << std::endl;
		std::cout << rooms << std::endl;
	}
};

int main(int argc, char* argv[]) {
	Schedule* s = new Schedule;
	DFS<Schedule> e(s);
	delete s;

	while (Schedule* s = e.next()) {
		s->print(); delete s;
	}
	return 0;
}