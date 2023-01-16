package team_project.buy_idea.repository.order;

import org.springframework.data.jpa.repository.JpaRepository;
import team_project.buy_idea.entity.order.DeliveryAddress;

public interface AddressRepository extends JpaRepository<DeliveryAddress, Long> {
}
