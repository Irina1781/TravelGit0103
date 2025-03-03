import styled from "styled-components";
import "../styles.css";

console.clear();

type City = {
  id: number;
  title: string;
};

type Type = {
  id: number;
  title: string;
  color: string;
};

const Controls = styled.div`
  display: flex;
  gap: 10px;
  justify-content: center;
`;

const Label = styled.div`
  border-radius: 3px;
  background-color: "#eee";
  padding: 5px 10px;
`;

const TagSpan = styled.span<{ color: string }>`
  margin: 0 5px 0 15px;
  position: relative;

  &:before {
    content: "";
    height: 10px;
    width: 10px;
    left: -15px;
    top: 3px;
    background-color: ${(p) => p.color};
    border-radius: 3px;
    position: absolute;
  }
`;
