import logger from "../logger.js";
import { Park } from "../models/parks.js";

// ask jim if we can combine these somehow
export type RawRide = {
  rideName: string;
  yearOpened: number;
  votes: number;
  parkName?: string;
};

export type BaseRide = {
  rideName: string;
  yearOpened: number;
  votes: number;
  parkID: number;
};

export function prepareRidesData(ridesData: RawRide[], parksData: Park[]) {
  const formattedRides = ridesData.map((ride): BaseRide | null => {
    const parkName = ride.parkName;
    delete ride.parkName;
    const park = parksData.filter((park) => park.park_name === parkName)[0];
    if (!park) {
      logger.warn(
        `${parkName} for ride ${ride.rideName} does not exists. ${ride.rideName} will not be added.`
      );
      return null;
    }
    return { ...ride, parkID: park.parkID };
  });
  return formattedRides.filter((ride) => ride && ride) as BaseRide[];
}

export function arrangeRidesData(
  rideData: BaseRide[]
): [rideName: string, yearOpened: number, parkID: number, votes: number][] {
  return rideData.map(
    ({
      rideName: ride_name,
      yearOpened: year_opened,
      parkID: park_id,
      votes,
    }) => [ride_name, year_opened, park_id, votes]
  );
}
