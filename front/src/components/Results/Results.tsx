import React, { FC } from "react";
import List from './components/List';

interface ResultInterface {
    resultData: any[];
    climate: any[];
    timezone: any[];
    cityList: any[];
}

const Results: FC<ResultInterface> = ({ resultData,climate,timezone, cityList }) => {
    return <List results={resultData} climate={climate} timezone={timezone} cityList={cityList}/>;
};

export default Results;
