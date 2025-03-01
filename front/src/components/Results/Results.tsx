import React, { FC } from "react";
import List from './components/List';

interface ResultInterface {
    resultData: any[];
    climate: any[];
    timezone: any[];
}

const Results: FC<ResultInterface> = ({ resultData,climate,timezone }) => {
    return <List results={resultData} climate={climate} timezone={timezone}/>;
};

export default Results;
