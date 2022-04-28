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
		IntVar db2(lectures[0]), db2_room(rooms[0]),
			its(lectures[1]), its(rooms[1]),
			ki(lectures[2]), room_ki(rooms[2]),
			lp(lectures[3]), room_lp(rooms[3]),
			fp(lectures[4]), room_fp(rooms[4]),
			aswe(lectures[5]), room_aswe(rooms[5]),
			sv(lectures[6]), room_sv(rooms[6]),
			db1(lectures[7]), room_db1(rooms[7]),
			tinf3(lectures[8]), room_tinf3(rooms[8]),
			swe(lectures[9]), room_swe(rooms[9]),
			m2(lectures[10]), room_m2(rooms[10]),
			p2(lectures[11]), room_p2(rooms[11]),
			ra(lectures[12]), room_ra(rooms[12]),
			bs(lectures[13]), room_bs(rooms[13]),
			dt(lectures[14]), room_dt(rooms[14]),
			tinf1(lectures[15]), room_tinf1(rooms[15]),
			m1(lectures[16]), room_m1(rooms[16]),
			p1(lectures[17]), room_p1(rooms[17]),
			vla(lectures[18]), room_vla(rooms[18]),
			we(lectures[19]), room_we(rooms[19]),
			bwl(lectures[20]), room_bwl(rooms[20]);

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

		IntVarArray roomHelper(*this, 21);
		IntVarArray dayHelper(*this, 21);

		IntVarArray dayHelper19(*this, 7);
		IntVarArray dayHelper20(*this, 7);
		IntVarArray dayHelper21(*this, 7);

		for (int loop = 0; loop < lectures.size(); loop++) {
			roomHelper[loop] = expr(*this, lectures[loop] + rooms[loop] * 15);
			dayHelper[loop] = expr(*this, (lectures[loop] - 1) / 3);
			if (loop < 7) {
				dayHelper19[loop] = dayHelper[loop];
			}
			else if (loop < 14) {
				dayHelper20[loop - 7] = dayHelper[loop];
			}
			else if (loop < 21) {
				dayHelper21[loop - 7] = dayHelper[loop];
			}
		}

		IntVarArray daysB(*this, 4, 1, 15);
		IntVarArray daysC(*this, 3, 1, 15);
		IntVarArray daysG(*this, 3, 1, 15);
		
		IntVar mon19; count(*this, dayHelper19, 0, IRT_EQ, mon19);
		IntVar tue19; count(*this, dayHelper19, 1, IRT_EQ, tue19);
		IntVar wed19; count(*this, dayHelper19, 2, IRT_EQ, wed19);
		IntVar thu19; count(*this, dayHelper19, 3, IRT_EQ, thu19);
		IntVar fri19; count(*this, dayHelper19, 4, IRT_EQ, fri19);

		IntVar mon20; count(*this, dayHelper20, 0, IRT_EQ, mon20);
		IntVar tue20; count(*this, dayHelper20, 1, IRT_EQ, tue20);
		IntVar wed20; count(*this, dayHelper20, 2, IRT_EQ, wed20);
		IntVar thu20; count(*this, dayHelper20, 3, IRT_EQ, thu20);
		IntVar fri20; count(*this, dayHelper20, 4, IRT_EQ, mon20);

		IntVar mon21;
		IntVar tue21;
		IntVar wed21;
		IntVar thu21;
		IntVar fri21;

		IntVar monB;
		IntVar tueB;
		IntVar wedB;
		IntVar thuB;
		IntVar friB;

		IntVar monC;
		IntVar tueC;
		IntVar wedC;
		IntVar thuC;
		IntVar friC;

		IntVar monG;
		IntVar tueG;
		IntVar wedG;
		IntVar thuG;
		IntVar friG;


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
		
		distinct(*this, roomHelper);
	}
};