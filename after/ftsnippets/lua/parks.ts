export type RawPark = {
  park_name: string;
  yearOpened: number;
  annualAttendance: number;
};

export function arrangeParksData(
  parksData: RawPark[]
): [parkName: string, yearOpened: number, annualAttendance: number][] {
  return parksData.map(
    ({ park_name: parkName, yearOpened, annualAttendance }) => [
      parkName,
      yearOpened,
      annualAttendance,
    ]
  );
}
