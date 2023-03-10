pragma solidity ^0.5.0;

contract MedicalCertificate {
    uint256 counter = 0;

    enum certCategory{
        incident,
        death,
        suicide
    }

    struct medicalCert{
        bytes32 ID;
        uint256 HospitalID;
        string name;
        string NRIC;
        uint256 sex;
        uint256 birthdate; //YYYYMMDD
        string race;
        string nationality;
        certCategory incident;
        uint256 dateTimeIncident; //YYYYMMDDHHMM
        string placeIncident;
        string causeIncident;
        string titleOfCertifier;
        string Institution;
        //stakeholder Stakeholder;
        //[]insuranceCompany access;
    }

    mapping(bytes32 => medicalCert) public MC;

    event mcCreated(uint256 numMC);


    function add(uint256 hospital, string memory name, string memory NRIC, uint256 sex, 
                uint256 birthdate, string memory race, string memory nationality, 
                certCategory incidentType, uint256 incidentYYYYMMDDHHMM, 
                string memory place, string memory cause, string memory titleNname, string memory institution) public {
        bytes32 id = keccak256(abi.encodePacked(counter, name, NRIC));
        medicalCert memory mc = medicalCert(
            id, 
            hospital,
            name,
            NRIC,
            sex,
            birthdate,
            race,
            nationality,
            incidentType,
            incidentYYYYMMDDHHMM,
            place,
            cause,
            titleNname,
            institution
            // stakeholder,
            //[]insuranceCompany
            );
        
        
        MC[id] = mc;

        emit mcCreated(counter);

        counter = counter + 1;
        
    }

    //giveAccess(byte32 ID, insuranceCompany company){
        //require(msg.sender==MC[ID].stakeholder.address)
        //MC[ID].access.push(company);
    //}

    function getMC(bytes32 id) public view returns(uint256, string memory, string memory, uint256, uint256, string memory, string memory, certCategory, uint256, string memory, string memory, string memory, string memory) {
        return(MC[id].HospitalID, MC[id].name, MC[id].NRIC, MC[id].sex, MC[id].birthdate, MC[id].race, MC[id].nationality, MC[id].incident, MC[id].dateTimeIncident, MC[id].placeIncident, MC[id].causeIncident, MC[id].titleOfCertifier, MC[id].Institution);

    }
    

}